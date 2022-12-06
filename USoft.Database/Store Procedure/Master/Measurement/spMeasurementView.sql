IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementView'
	DROP PROCEDURE [dbo].[spMeasurementView]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementView		
	@pivchMeasurementCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		MeasurementCode,
		MeasurementName,
		IsActive
	FROM
		MsMeasurement WITH(NOLOCK)
	WHERE
		MeasurementCode = @pivchMeasurementCode
END
GO

SET NOCOUNT OFF
GO       