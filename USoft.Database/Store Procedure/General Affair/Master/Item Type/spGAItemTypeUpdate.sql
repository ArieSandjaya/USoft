IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemTypeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemTypeUpdate'
	DROP PROCEDURE [dbo].[spGAItemTypeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAItemTypeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemTypeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update GA Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemTypeUpdate
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(255),
	@pivchItemGroupCode VARCHAR(10),
	@pivchMeasurementCode VARCHAR(10),
	@pivchDescription VARCHAR(255),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemTypeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE GA_ItemType
		SET
			ItemTypeName = @pivchItemTypeName,
			ItemGroupCode = @pivchItemGroupCode,
			MeasurementCode = @pivchMeasurementCode,
			Description = @pivchDescription,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ItemTypeCode = @pivchItemTypeCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN GAItemTypeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemTypeUpdate
	END
END
GO

SET NOCOUNT OFF
GO         