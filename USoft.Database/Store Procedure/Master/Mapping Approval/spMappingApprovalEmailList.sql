IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailList'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailList]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval E-Mail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailList		
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ApprovalEmailID,
		b.UserName,
		b.Email
	FROM
		MsMappingApprovalMail AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.UserEmail = b.UserId
	WHERE
		a.ApprovalID = @piintApprovalID
END
GO

SET NOCOUNT OFF
GO   