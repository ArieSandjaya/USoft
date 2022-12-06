 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserEmail]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserEmail'
	DROP PROCEDURE [dbo].[spGetUserEmail]
END
GO

PRINT 'CREATE PROCEDURE spGetUserEmail'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserEmail
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User Email
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserEmail
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserName,
		Email
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		IsActive = 1
		AND UserId = @pivchUserId
END
GO

SET NOCOUNT OFF
GO         