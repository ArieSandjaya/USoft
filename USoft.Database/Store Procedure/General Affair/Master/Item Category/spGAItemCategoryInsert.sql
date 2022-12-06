IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemCategoryInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemCategoryInsert'
	DROP PROCEDURE [dbo].[spGAItemCategoryInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAItemCategoryInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemCategoryInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert GA Item Category Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemCategoryInsert
	@pivchItemCategoryCode VARCHAR(10),
	@pivchItemCategoryName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemCategoryInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM GA_ItemCategory WITH(NOLOCK) 
				WHERE ItemCategoryCode =  @pivchItemCategoryCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Category Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO GA_ItemCategory (
				ItemCategoryCode,
				ItemCategoryName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemCategoryCode,
				@pivchItemCategoryName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN GAItemCategoryInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemCategoryInsert
	END
END
GO

SET NOCOUNT OFF
GO       