IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemTransUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item Transfer
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransUpdateStatus
	@pivchItemTransCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@MinID INT,
			@MaxID INT	
		
		DECLARE @tmpDetail AS TABLE (
			ID INT IDENTITY,
			ITItemTransDtlCode VARCHAR(10),
			ITItemTransCode VARCHAR(8),
			ITItemCode VARCHAR(10),
			ConditionCode INT,
			UsedBy VARCHAR(50),
			PrivilegeCode VARCHAR(4),
			BranchId_From INT,
			BranchId_To INT
		)

		-- Reject
		IF (@pivchStatus = 'D') --back to Draft
		BEGIN --1
			UPDATE IT_ItemTrans
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				ITItemTransCode = @pivchItemTransCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			---validation
			IF(
				NOT EXISTS(
					SELECT ''
					FROM IT_ItemTransDtl WITH(NOLOCK)
					WHERE
						ITItemTransCode = @pivchItemTransCode
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END	
		
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemTrans
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemTransCode = @pivchItemTransCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				INSERT INTO @tmpDetail (
					ITItemTransDtlCode,
					ITItemTransCode,
					ITItemCode,
					ConditionCode,
					UsedBy,
					PrivilegeCode,
					BranchId_From,
					BranchId_To
				)
				SELECT
					a.ITItemTransDtlCode,
					a.ITItemTransCode,
					a.ITItemCode,
					a.ConditionCode,
					a.UsedBy,
					a.PrivilegeCode,
					b.BranchId_From,
					b.Branchid_To
				FROM
					IT_ItemTransDtl AS a WITH(NOLOCK)
					INNER JOIN IT_ItemTrans AS b WITH(NOLOCK) ON
						a.ITItemTransCode = b.ITItemTransCode
				WHERE
					b.ITItemTransCode = @pivchItemTransCode
					
				IF @@ERROR <> 0
					GOTO ExitSP

				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpDetail

				WHILE (@MinID <= @MaxID)
				BEGIN
					-- Validasi Detail
					IF (
						NOT EXISTS (
							SELECT ''
							FROM
								@tmpDetail AS a
								INNER JOIN IT_Item AS b WITH(NOLOCK) ON
									a.ITItemCode = b.ITItemCode
							WHERE
								b.IsActive = 1
								AND (
									ISNULL(a.BranchId_From,0) = ISNULL(b.BranchId,0)
									OR
									b.ITItemOutCode IS NOT NULL
								)
								AND a.ID = @MinID
						)
					)
					BEGIN
						SELECT
							@ErrMsg = 'Invalid Data Detail, please check detail Item ' + ITItemCode
						FROM
							@tmpDetail
						WHERE
							ID = @MinID
							
						GOTO ExitSP
					END
					
					UPDATE
						a
					SET
						a.ITItemTransDtlCode = b.ITItemTransDtlCode,
						a.ConditionCode = b.ConditionCode,
						a.UsedBy = b.UsedBy,
						a.PrivilegeCode = b.PrivilegeCode,
						a.BranchId = b.Branchid_To,
						a.update_date = GETDATE(),
						a.update_by = @pivchInputID
					FROM
						IT_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpDetail AS b ON
							a.ITItemCode = b.ITItemCode
					WHERE
						a.IsActive = 1
						AND b.ID = @MinID
					
					IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) -- Check Error dan Check Affected Update Row
					BEGIN
						SET @ErrMsg = 'Verify Data Detail Transfer Error'
						GOTO ExitSP
					END
					
					-- Update History
					INSERT INTO IT_Item_History
					(	ITItemCode,	
						ITItemInDtlCode,
						ITItemTransDtlCode,
						ITItemOutCode,	
						ItemTypeCode,	
						SerialNo,	
						Barcode,
						Description,	
						ParentCode,	
						ConditionCode,	
						BranchId,	
						UsedBy,	
						PrivilegeCode,	
						IsActive,	
						StatusIn,	
						StatusOut,
						Remark,
						created_date,
						created_by )
					SELECT 
						a.ITItemCode,	
						a.ITItemInDtlCode,
						a.ITItemTransDtlCode,
						a.ITItemOutCode,	
						a.ItemTypeCode,	
						a.SerialNo,	
						a.Barcode,
						a.Description,	
						a.ParentCode,	
						a.ConditionCode,	
						a.BranchId,	
						a.UsedBy,	
						a.PrivilegeCode,	
						a.IsActive,	
						a.StatusIn,	
						a.StatusOut,
						CASE 
							WHEN b.BranchId_From IS NOT NULL THEN 'Transfer from ' + c.BranchName  
							ELSE 'Transfer from Warehouse'
						END,
						a.update_date,
						a.update_by
					FROM
						IT_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpDetail AS b ON
							a.ITItemCode = b.ITItemCode
						LEFT JOIN MsBranch AS c ON 
							b.BranchId_From = c.BranchId
					WHERE
						b.ID = @MinID
						

					IF @@ERROR <> 0
						GOTO ExitSP
						
					SET @MinID = @MinID + 1
				END
					
				UPDATE IT_ItemTrans
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemTransCode = @pivchItemTransCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemTransUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO     