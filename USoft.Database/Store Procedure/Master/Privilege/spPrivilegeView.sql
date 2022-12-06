IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeView'
	DROP PROCEDURE [dbo].[spPrivilegeView]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeView		
	@pivchPrivilegeCode VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.PrivilegeCode,
		a.PrivilegeName,
		a.DepartementCode,
		b.DepartementName,
		a.OldCode,
		a.IsActive
	FROM
		MsPrivilege AS a WITH(NOLOCK)
		INNER JOIN MsDepartement AS b WITH(NOLOCK) ON
			a.DepartementCode = b.DepartementCode
	WHERE
		a.PrivilegeCode = @pivchPrivilegeCode
END
GO

SET NOCOUNT OFF
GO    