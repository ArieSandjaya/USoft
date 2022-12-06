IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserLogon]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserLogon'
	DROP PROCEDURE [dbo].[spGetUserLogon]
END
GO

PRINT 'CREATE PROCEDURE spGetUserLogon'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserLogon / MsUserLogon
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User Logon
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserLogon		
	@UserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		Pass,
		UserName,
		BranchId,
		Email,
		ChangePass,
		--PriviledgeCode
		PrivilegeCode
	FROM
		MsUsers WITH (NOLOCK)
	WHERE
		UserId = @UserId
		AND IsActive = 1
END
GO

SET NOCOUNT OFF
GO        