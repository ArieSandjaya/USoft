IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemCategoryUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemCategoryUpdate'
	DROP PROCEDURE [dbo].[spGAItemCategoryUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAItemCategoryUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemCategoryUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update GA Item Category Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemCategoryUpdate
	@pivchItemCategoryCode VARCHAR(10),
	@pivchItemCategoryName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemCategoryUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE GA_ItemCategory
		SET
			ItemCategoryName = @pivchItemCategoryName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ItemCategoryCode = @pivchItemCategoryCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN GAItemCategoryUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemCategoryUpdate
	END
END
GO

SET NOCOUNT OFF
GO       