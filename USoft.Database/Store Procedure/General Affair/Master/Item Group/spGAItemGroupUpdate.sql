IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemGroupUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemGroupUpdate'
	DROP PROCEDURE [dbo].[spGAItemGroupUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAItemGroupUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemGroupUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update GA Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemGroupUpdate
	@pivchItemGroupCode VARCHAR(10),
	@pivchItemGroupName VARCHAR(100),
	@pivchItemCategoryCode VARCHAR(10),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemGroupUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE GA_ItemGroup
		SET
			ItemGroupName = @pivchItemGroupName,
			ItemCategoryCode = @pivchItemCategoryCode,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ItemGroupCode = @pivchItemGroupCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN GAItemGroupUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemGroupUpdate
	END
END
GO

SET NOCOUNT OFF
GO        