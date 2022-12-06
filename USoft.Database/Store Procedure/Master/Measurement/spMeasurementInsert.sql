IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementInsert'
	DROP PROCEDURE [dbo].[spMeasurementInsert]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementInsert
	@pivchMeasurementCode VARCHAR(10),
	@pivchMeasurementName VARCHAR(30),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MeasurementInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsMeasurement WITH(NOLOCK) 
				WHERE MeasurementCode =  @pivchMeasurementCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Measurement Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsMeasurement (
				MeasurementCode,
				MeasurementName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchMeasurementCode,
				@pivchMeasurementName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN MeasurementInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MeasurementInsert
	END
END
GO

SET NOCOUNT OFF
GO       