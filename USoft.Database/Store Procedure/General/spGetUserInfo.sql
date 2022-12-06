IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserInfo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserInfo'
	DROP PROCEDURE [dbo].[spGetUserInfo]
END
GO

PRINT 'CREATE PROCEDURE spGetUserInfo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserInfo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User Information
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserInfo		
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.UserId,
		a.UserName,
		a.BranchId,
		a.PrivilegeCode,
		b.DepartementCode,
		ISNULL(a.IsAllBranch,0) AS IsAllBranch,
		ISNULL(a.IsActive,0) AS IsActive
	FROM
		MsUsers AS a WITH(NOLOCK)
		LEFT JOIN MsPrivilege AS b WITH(NOLOCK) ON
			a.PrivilegeCode = b.PrivilegeCode
	WHERE
		a.UserId = @pivchUserId
END
GO

SET NOCOUNT OFF
GO         