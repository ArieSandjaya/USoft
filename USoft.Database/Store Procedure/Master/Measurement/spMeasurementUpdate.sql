IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementUpdate'
	DROP PROCEDURE [dbo].[spMeasurementUpdate]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementUpdate
	@pivchMeasurementCode VARCHAR(10),
	@pivchMeasurementName VARCHAR(30),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MeasurementUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsMeasurement
		SET
			MeasurementName = @pivchMeasurementName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			MeasurementCode = @pivchMeasurementCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MeasurementUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MeasurementUpdate
	END
END
GO

SET NOCOUNT OFF
GO       