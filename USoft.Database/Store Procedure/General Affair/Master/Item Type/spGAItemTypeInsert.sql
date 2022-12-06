IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemTypeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemTypeInsert'
	DROP PROCEDURE [dbo].[spGAItemTypeInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAItemTypeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemTypeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert GA Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemTypeInsert
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(255),
	@pivchItemGroupCode VARCHAR(10),
	@pivchMeasurementCode VARCHAR(10),
	@pivchDescription VARCHAR(255),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAItemTypeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM GA_ItemType WITH(NOLOCK) 
				WHERE ItemTypeCode =  @pivchItemTypeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Type Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO GA_ItemType (
				ItemTypeCode,
				ItemTypeName,
				ItemGroupCode,
				MeasurementCode,
				Description,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemTypeCode,
				@pivchItemTypeName,
				@pivchItemGroupCode,
				@pivchMeasurementCode,
				@pivchDescription,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN GAItemTypeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAItemTypeInsert
	END
END
GO

SET NOCOUNT OFF
GO         