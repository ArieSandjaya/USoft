IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalView'
	DROP PROCEDURE [dbo].[spMappingApprovalView]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalView
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ApprovalID,
		a.MenuId,
		b.MenuName,
		a.DepartementCode,
		c.DepartementName,
		a.ParentCode,
		d.PrivilegeName AS ParentName,
		a.UserIdApproval,
		e.UserName AS UserNameApproval,
		a.State,
		a.StateDescription,
		a.IsActive,
		a.IsBranch
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsMenu AS b WITH(NOLOCK) ON
			(a.MenuId = b.MenuId)
		LEFT JOIN MsDepartement AS c WITH(NOLOCK) ON
			(a.DepartementCode = c.DepartementCode)
		LEFT JOIN MsPrivilege AS d WITH(NOLOCK) ON
			(a.ParentCode = d.PrivilegeCode)
		LEFT JOIN MsUsers AS e WITH(NOLOCK) ON
			(a.UserIdApproval = e.UserId)
	WHERE
		a.ApprovalID = @piintApprovalID
END
GO

SET NOCOUNT OFF
GO     