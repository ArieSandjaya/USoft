IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTypeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTypeInsert'
	DROP PROCEDURE [dbo].[spITItemTypeInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemTypeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTypeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-03
**	Description		: SP untuk Insert data IT Item Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTypeInsert
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemTypeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_ItemType WITH(NOLOCK) 
				WHERE ItemTypeCode = @pivchItemTypeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Type Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO IT_ItemType (
				ItemTypeCode,
				ItemTypeName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemTypeCode,
				@pivchItemTypeName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ITItemTypeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemTypeInsert
	END
END
GO

SET NOCOUNT OFF
GO      