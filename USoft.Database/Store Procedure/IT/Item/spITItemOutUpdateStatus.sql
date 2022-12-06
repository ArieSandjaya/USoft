IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemOutUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdateStatus
	@pivchItemOutCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@ITItemCode VARCHAR(10),
			@ConditionCode INT,
			@StatusOut INT
		
		-- Reject
		IF (@pivchStatus = 'D')  --back to Draft
		BEGIN --1
			UPDATE IT_ItemOut
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			SELECT
				@ITItemCode = ITItemCode,
				@ConditionCode = ConditionCode,
				@StatusOut = StatusOut
			FROM
				IT_ItemOut WITH(NOLOCK)
			WHERE
				ITItemOutCode = @pivchItemOutCode
				
			IF(
				EXISTS(
					SELECT ''
					FROM IT_Item WITH(NOLOCK)
					WHERE
						ITItemCode = @ITItemCode
						AND (
							ITItemOutCode IS NOT NULL
							OR IsActive = 0
						)
				)
			)
			BEGIN
				SET @ErrMsg = 'Item with code ' + @ITItemCode + ' is under Repair or already Dispose.'
				GOTO ExitSP
			END
			
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemOut
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				
				--update ITItem
				UPDATE IT_Item 
				SET 
					ITItemOutCode = @pivchItemOutCode,
					ConditionCode = @ConditionCode,
					BranchId = NULL,
					UsedBy = NULL,
					PrivilegeCode = NULL,
					IsActive = 0,
					StatusOut = @StatusOut,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemCode = @ITItemCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
				
				--insert ITHistory	
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
					ITItemCode,	
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
					CASE 
						WHEN StatusOut = 1 THEN 'Repair by Vendor'
						WHEN StatusOut = 2 THEN 'Dispose'
					END,
					update_date,
					update_by 
				FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @ITItemCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
					
				UPDATE IT_ItemOut
				SET
					Status = @pivchStatus,
					ApprovalState = 2, ----ISNULL(@piintApprovalState,0) + 1,
					RepairStatus = CASE
										WHEN @StatusOut = '1' THEN 1  --InProgress if statusOut Repair
										ELSE NULL                     --NULL if statusOut Dispose
									END,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemOutUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO