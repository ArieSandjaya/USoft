IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemGroupInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemGroupInsert'
	DROP PROCEDURE [dbo].[spGAItemGroupInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAItemGroupInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemGroupInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert GA Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemGroupInsert
	@pivchItemGroupCode VARCHAR(10),
	@pivchItemGroupName VARCHAR(100),
	@pivchItemCategoryCode VARCHAR(10),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemGroupInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM GA_ItemGroup WITH(NOLOCK) 
				WHERE ItemGroupCode =  @pivchItemGroupCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Group Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO GA_ItemGroup (
				ItemGroupCode,
				ItemGroupName,
				ItemCategoryCode,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemGroupCode,
				@pivchItemGroupName,
				@pivchItemCategoryCode,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN GAItemGroupInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemGroupInsert
	END
END
GO

SET NOCOUNT OFF
GO        