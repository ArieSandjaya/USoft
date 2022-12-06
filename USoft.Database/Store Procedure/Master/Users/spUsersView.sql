IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersView'
	DROP PROCEDURE [dbo].[spUsersView]
END
GO

PRINT 'CREATE PROCEDURE spUsersView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersView		
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		UserName,
		BranchId,
		IsActive,
		Email,
		CanSendMail,
		ChangePass,
		PrivilegeCode,
		IsAllBranch
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		UserId = @pivchUserId
END
GO

SET NOCOUNT OFF
GO    