IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailUpdate'
	DROP PROCEDURE [dbo].[spITItemInDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Update data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailUpdate
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8),
	@piintStatusIn INT,
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemOutCode VARCHAR(8),
	@pivchSerialNo VARCHAR(50),
	@pivchBarcode VARCHAR(50),
	@pivchDescription VARCHAR(255),
	@piintConditionCode INT,
	@pivchInputID VARCHAR(50)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF( @piintStatusIn = 1 ) ---New
			BEGIN
				IF(
					EXISTS(
						SELECT '' FROM IT_Item WITH(NOLOCK)
						WHERE IsActive = 1
							AND ItemTypeCode = @pivchItemTypeCode
							AND SerialNo = @pivchSerialNo 
					)
				  )
					BEGIN
						SET @ErrMsg = 'Item with SerialNo '+@pivchSerialNo+ ' is already in Database.'
						GOTO ExitSP
					END
					
				UPDATE IT_ItemInDtl
				SET
					StatusIn = @piintStatusIn,
					ItemTypeCode = @pivchItemTypeCode,
					SerialNo = @pivchSerialNo,
					Barcode = @pivchBarcode,
					Description = @pivchDescription,
					ConditionCode = @piintConditionCode,
					update_date = GETDATE(),
					update_by = @pivchInputID
				WHERE
					ITItemInDtlCode = @pivchItemInDetailCode
					and ITItemInCode = @pivchItemInCode
			END
			
		ELSE ---Return / Replace
			BEGIN
				IF( 
					NOT EXISTS(
						SELECT '' 
						FROM IT_ItemOut WITH(NOLOCK)
						WHERE ITItemOutCode = @pivchItemOutCode AND
							  StatusOut = 1 AND ---Repair
							  RepairStatus = 1 ----InProgress
					)
				)
					BEGIN
						SET @ErrMsg = 'Item with Out Code '+ @pivchItemOutCode + 'does not exists in Database.'
						GOTO ExitSP
					END
				
				UPDATE IT_ItemInDtl
					SET
						ITItemOutCode = @pivchItemOutCode,
						StatusIn=@piintStatusIn,
						ItemTypeCode=@pivchItemTypeCode,
						SerialNo=CASE 
									WHEN @piintStatusIn <> 2 THEN @pivchSerialNo ---if status New/Replace
									WHEN @piintStatusIn = 2 THEN  (				 ---if status Return
											SELECT
												b.SerialNo
											FROM
												IT_ItemOut AS a WITH(NOLOCK)
												INNER JOIN IT_Item AS b WITH(NOLOCK) ON
													a.ITItemCode = b.ITItemCode
											WHERE
												a.ITItemOutCode = @pivchItemOutCode
										)
									ELSE NULL
								END,
						Barcode=@pivchBarcode,
						Description=CASE 
										WHEN @piintStatusIn <> 2 THEN @pivchDescription ---if status New/Replace
										WHEN @piintStatusIn = 2 THEN  (				 ---if status Return
												SELECT
													b.Description
												FROM
													IT_ItemOut AS a WITH(NOLOCK)
													INNER JOIN IT_Item AS b WITH(NOLOCK) ON
														a.ITItemCode = b.ITItemCode
												WHERE
													a.ITItemOutCode = @pivchItemOutCode
											)
										ELSE NULL
									END,
						ConditionCode=@piintConditionCode,
						update_date=GETDATE(),
						update_by=@pivchInputID
					WHERE
						ITItemInDtlCode = @pivchItemInDetailCode
						and ITItemInCode = @pivchItemInCode
			END
				
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO    