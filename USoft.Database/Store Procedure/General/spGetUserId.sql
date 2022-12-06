IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserId]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserId'
	DROP PROCEDURE [dbo].[spGetUserId]
END
GO

PRINT 'CREATE PROCEDURE spGetUserId'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserId / MsGetUserid
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User ID
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserId
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		UserName,
		PriviledgeCode
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		IsActive = 1
END
GO

SET NOCOUNT OFF
GO         