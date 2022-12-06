IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemInUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemInUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInUpdateStatus
	@pivchItemInCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@MinID INT,
			@MaxID INT,
			@ItemTypeCode VARCHAR(10),
			@StatusIn INT,
			@ITItemOutCode VARCHAR(8),
			@SerialNo VARCHAR(50),
			@Barcode VARCHAR(50),
			@Description VARCHAR(255),
			@ParentCode VARCHAR(12),
			@ConditionCode INT
		
		DECLARE @tmpDetail AS TABLE (
			ID INT IDENTITY,
			ITItemInDtlCode	VARCHAR(10),
			ITItemInCode VARCHAR(8),
			ItemTypeCode VARCHAR(10),
			BranchId INT,----
			StatusIn INT,
			ITItemOutCode VARCHAR(8),
			SerialNo VARCHAR(50),
			Barcode VARCHAR(50),
			Description VARCHAR(255),
			ParentCode VARCHAR(12),
			ConditionCode INT
		)

		-- Reject
		IF (@pivchStatus = 'D') ---back to Draft
		BEGIN --1
			UPDATE IT_ItemIn
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				ITItemInCode = @pivchItemInCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			---validation
			IF(
				NOT EXISTS(
					SELECT ''
					FROM IT_ItemInDtl WITH(NOLOCK)
					WHERE
						ITItemInCode = @pivchItemInCode
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END	
		
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemIn
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemInCode = @pivchItemInCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				INSERT INTO @tmpDetail (
					ITItemInDtlCode,
					ITItemInCode,
					ItemTypeCode,
					BranchId,---
					StatusIn,
					ITItemOutCode,
					SerialNo,
					Barcode,
					Description,
					ParentCode,
					ConditionCode
				)
				SELECT
					a.ITItemInDtlCode,
					a.ITItemInCode,
					a.ItemTypeCode,
					b.BranchId,---
					a.StatusIn,
					a.ITItemOutCode,
					a.SerialNo,
					a.Barcode,
					a.Description,
					a.ParentCode,
					a.ConditionCode
				FROM
					IT_ItemInDtl AS a WITH(NOLOCK)
					INNER JOIN IT_ItemIn AS b WITH(NOLOCK) ON
						a.ITItemInCode = b.ITItemInCode
				WHERE
					a.ITItemInCode = @pivchItemInCode
					
				IF @@ERROR <> 0
					GOTO ExitSP

				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpDetail

				WHILE (@MinID <= @MaxID)
				BEGIN
					-- Verify Existing Item
					SELECT
						@ItemTypeCode = ItemTypeCode,
						@StatusIn = StatusIn,
						@ITItemOutCode = ITItemOutCode,
						@SerialNo = SerialNo,
						@Barcode = Barcode,
						@Description = Description,
						@ParentCode = ParentCode,
						@ConditionCode = ConditionCode
					FROM
						@tmpDetail
					WHERE
						ID = @MinID
						
					
					DECLARE @NewITItemCode VARCHAR(10)
						SET @NewITItemCode = dbo.fnGenItemCode()
						
					IF(@StatusIn = 1)--NEW Item
						BEGIN
							IF( EXISTS( SELECT '' FROM IT_Item WITH(NOLOCK) 
										WHERE ItemTypeCode = @ItemTypeCode AND 
											  SerialNo = @SerialNo AND 
											  IsActive = 1 ))
							BEGIN
								SET @ErrMsg = 'Item with SerialNo ' + @SerialNo + ' is already in database.'
								GOTO ExitSP		
							END
						
							INSERT INTO IT_Item (
								ITItemCode,ITItemInDtlCode,ItemTypeCode,BranchId,StatusIn,SerialNo,Barcode,Description,ParentCode,ConditionCode,IsActive,created_date,created_by,update_date,update_by
							)
							SELECT @NewITItemCode,ITItemInDtlCode,ItemTypeCode,BranchId,StatusIn,SerialNo,Barcode,Description,ParentCode,ConditionCode,1,GETDATE(),@pivchInputID,GETDATE(),@pivchInputID
							FROM @tmpDetail WHERE ID = @MinID
							
							IF @@ERROR <> 0
								GOTO ExitSP
								
							---insert IT_Item_History
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
								'New item',
								update_date,
								update_by 
							FROM 
								IT_Item WITH(NOLOCK)
							WHERE
								ITItemCode = @NewITItemCode
							
							IF @@ERROR <> 0
								GOTO ExitSP	
						END	
					
					ELSE
						BEGIN
							IF( 
								NOT EXISTS(
									SELECT '',b.SerialNo 
									FROM IT_ItemOut AS a WITH(NOLOCK)
									INNER JOIN IT_Item AS b WITH(NOLOCK)
										ON (a.ITItemCode = b.ITItemCode)
									WHERE a.ITItemOutCode = @ITItemOutCode AND
										  a.StatusOut = 1 AND  -----Repair
										  a.RepairStatus = 1 AND ---InProgress
										  b.IsActive = 0
								)
							)
							
							BEGIN
								SET @ErrMsg = 'Item with Out Code '+ @ITItemOutCode + ' does not exists in Database.'
								GOTO ExitSP
							END
							
							IF(@StatusIn = 2)--RETURN
								BEGIN
									---update IT_Item
									UPDATE a 
									SET 
										--a.ITItemOutCode = NULL,
										a.ItemTypeCode = @ItemTypeCode,
										a.Barcode = CASE 
														 WHEN @Barcode != '' THEN @Barcode
													END,
										a.ConditionCode = @ConditionCode,
										a.BranchId = NULL,
										a.UsedBy = NULL,
										a.PrivilegeCode = NULL,
										a.IsActive = 1,
										a.StatusIn = @StatusIn,
										a.StatusOut = NULL,
										a.update_date = GETDATE(),
										a.update_by = @pivchInputID
									FROM IT_Item AS a
									INNER JOIN IT_ItemOut AS b ON (a.ITItemCode = b.ITItemCode)
									WHERE
										a.ITItemOutCode = @ITItemOutCode AND
										b.StatusOut = 1 AND
										a.IsActive = 0
	
									IF @@ERROR <> 0
										GOTO ExitSP
										
									---insert IT_Item_History
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
										'Repair done, Return from vendor',
										update_date,
										update_by 
									FROM 
										IT_Item
									WHERE
										ITItemOutCode = @ITItemOutCode
									
									IF @@ERROR <> 0
										GOTO ExitSP	
									
									---update IT_ItemOut
									UPDATE IT_ItemOut 
									SET 
										RepairStatus = 2, ---Done
										Remark = 'Return'
									WHERE
										ITItemOutCode = @ITItemOutCode AND
										StatusOut = 1
									
									IF @@ERROR <> 0
										GOTO ExitSP	
										
									---update IT_Item (ITItemOutCode=Null)
									UPDATE a 
									SET a.ITItemOutCode = NULL
									FROM IT_Item AS a
									INNER JOIN IT_ItemOut AS b ON (a.ITItemCode = b.ITItemCode)
									WHERE a.ITItemOutCode = @ITItemOutCode
	
									IF @@ERROR <> 0
										GOTO ExitSP	
								END
							
							ELSE IF(@StatusIn = 3)--REPLACE 
								BEGIN
									declare @oldItem AS TABLE (
										serial_no varchar(50),
										barcode varchar(50)
									)
									insert into @oldItem (serial_no, barcode)
										select a.SerialNo, a.Barcode 
										from IT_Item AS a 
										inner join IT_ItemOut AS b ON (a.ITItemCode = b.ITItemCode)
										where
											b.ITItemOutCode = @ITItemOutCode AND
											b.StatusOut = 1 AND
											a.IsActive = 0
								
								
									---update IT_Item
									UPDATE a 
									SET 
										--a.ITItemOutCode = NULL,
										a.BranchId = NULL,
										a.UsedBy = NULL,
										a.PrivilegeCode = NULL,
										a.StatusOut = 2,
										a.IsActive = 0,
										a.update_date = GETDATE(),
										a.update_by = @pivchInputID
									FROM IT_Item AS a 
									INNER JOIN IT_ItemOut AS b ON (a.ITItemCode = b.ITItemCode)
									WHERE
										b.ITItemOutCode = @ITItemOutCode AND
										b.StatusOut = 1 AND
										a.IsActive = 0
									
									IF @@ERROR <> 0
										GOTO ExitSP
										
									---insert IT_Item_History for old-item
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
										'Repair done, Replace with ' + @SerialNo + ' / ' + @Barcode,
										update_date,
										update_by 
									FROM 
										IT_Item WITH(NOLOCK)
									WHERE
										ITItemOutCode = @ITItemOutCode
									
									IF @@ERROR <> 0
										GOTO ExitSP		
										
									---update IT_ItemOut
									UPDATE IT_ItemOut 
									SET 
										RepairStatus = 2, ---Done
										Remark = 'Replace'
									WHERE
										ITItemOutCode = @ITItemOutCode AND
										StatusOut = 1

									IF @@ERROR <> 0
										GOTO ExitSP

									---insert new item replacement
									INSERT INTO IT_Item (
										ITItemCode,ITItemInDtlCode,ItemTypeCode,BranchId,StatusIn,SerialNo,Barcode,Description,ParentCode,ConditionCode,IsActive,created_date,created_by,update_date,update_by
									)
									SELECT @NewITItemCode,ITItemInDtlCode,ItemTypeCode,BranchId,StatusIn,SerialNo,Barcode,Description,ParentCode,ConditionCode,1,GETDATE(),@pivchInputID,GETDATE(),@pivchInputID
									FROM @tmpDetail WHERE ID = @MinID 
									
									IF @@ERROR <> 0
										GOTO ExitSP
									
									---insert Item_History for new item-replacement
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
										'New Item, Replacement from ' + (select serial_no from @oldItem) + ' / ' + (select barcode from @oldItem),
										update_date,
										update_by 
									FROM
										IT_Item WITH(NOLOCK)
									WHERE
										ITItemCode = @NewITItemCode
									
									IF @@ERROR <> 0
										GOTO ExitSP	
								END
						END
								
					SET @MinID = @MinID + 1 ----??						
				END
			
				IF @@ERROR <> 0
					GOTO ExitSP
					
				UPDATE IT_ItemIn
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ITItemInCode = @pivchItemInCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
			END --3
		END
			
	COMMIT TRAN ItemInUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO    