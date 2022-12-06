IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementView'
	DROP PROCEDURE [dbo].[spDepartementView]
END
GO

PRINT 'CREATE PROCEDURE spDepartementView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementView		
	@pivchDepartementCode VARCHAR(2)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		DepartementCode,
		DepartementName,
		IsActive
	FROM
		MsDepartement WITH(NOLOCK)
	WHERE
		DepartementCode = @pivchDepartementCode
END
GO

SET NOCOUNT OFF
GO   