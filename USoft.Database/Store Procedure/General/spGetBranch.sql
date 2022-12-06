IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranch]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranch'
	DROP PROCEDURE [dbo].[spGetBranch]
END
GO

PRINT 'CREATE PROCEDURE spGetBranch'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranch / MsGetBranch
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Branch
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranch
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		*
	FROM
		MsBranch WITH(NOLOCK)
	WHERE
		IsActive = 1
		AND BranchType = 1
END
GO

SET NOCOUNT OFF
GO          