IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailInsert'
	DROP PROCEDURE [dbo].[spITItemInDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-05-30
**	Description		: SP untuk Insert data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailInsert
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
	
	BEGIN TRAN ItemInDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@povchItemInDetailCode VARCHAR(10),
			@OldSerialNo VARCHAR(50)
			
		SELECT 	@povchItemInDetailCode = dbo.fnGenItemInDetailCode(@pivchItemInCode)
		
		IF( @piintStatusIn = 1 ) ---New
			BEGIN
				IF( 
					EXISTS(
						SELECT '' FROM IT_Item WITH(NOLOCK)
						WHERE IsActive = 1 AND 
							  ItemTypeCode = @pivchItemTypeCode AND 
							  SerialNo = @pivchSerialNo
					)
				)
					BEGIN
						SET @ErrMsg = 'Item with SerialNo '+@pivchSerialNo+ ' is already in Database.'
						GOTO ExitSP
					END
				
				INSERT INTO IT_ItemInDtl (
					ITItemInDtlCode,
					ITItemInCode,
					StatusIn,
					ItemTypeCode,
					SerialNo,
					Barcode,
					Description,
					ConditionCode,
					created_date,
					created_by
				)
				SELECT
					@povchItemInDetailCode,
					@pivchItemInCode,
					@piintStatusIn,
					@pivchItemTypeCode,
					@pivchSerialNo,
					@pivchBarcode,
					@pivchDescription,
					@piintConditionCode,
					GETDATE(),
					@pivchInputID
			END
		
		ELSE  ---Return / Replace
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
				
				INSERT INTO IT_ItemInDtl (
					ITItemInDtlCode,
					ITItemInCode,
					ITItemOutCode,
					StatusIn,
					ItemTypeCode,
					SerialNo,
					Barcode,
					Description,
					ConditionCode,
					created_date,
					created_by
				)
				SELECT
					@povchItemInDetailCode,
					@pivchItemInCode,
					@pivchItemOutCode,
					@piintStatusIn,
					@pivchItemTypeCode,
					CASE 
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
					@pivchBarcode,
					CASE 
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
					@piintConditionCode,
					GETDATE(),
					@pivchInputID
			END
		
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInDetailInsert
	RETURN --@povchItemInDetailCode
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO   