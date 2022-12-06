IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingApprovalEmailTo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingApprovalEmailTo'
	DROP PROCEDURE [dbo].[spGetMappingApprovalEmailTo]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingApprovalEmailTo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingApprovalEmailTo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Mapping Approval Email To
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingApprovalEmailTo
	@piintMenuId INT,
	@piintState INT
AS
BEGIN
	SET NOCOUNT ON
	
	-- Get User Approval by User ID
	SELECT
		b.UserName,
		b.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.UserIdApproval = b.UserId
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND b.IsActive = 1

	UNION

	-- Get User Approval by Privilege
	SELECT
		b.UserName,
		b.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.ParentCode = b.PrivilegeCode
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND b.IsActive = 1
		AND a.UserIdApproval IS NULL
END
GO

SET NOCOUNT OFF
GO          