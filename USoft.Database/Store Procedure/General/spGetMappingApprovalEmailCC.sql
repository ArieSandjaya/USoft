IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingApprovalEmailCC]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingApprovalEmailCC'
	DROP PROCEDURE [dbo].[spGetMappingApprovalEmailCC]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingApprovalEmailCC'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingApprovalEmailCC
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Mapping Approval Email CC
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingApprovalEmailCC
	@piintMenuId INT,
	@piintState INT
AS
BEGIN
	SET NOCOUNT ON
	
	-- Get User Approval by Email
	SELECT
		c.UserName,
		c.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsMappingApprovalMail AS b WITH(NOLOCK) ON 
			a.ApprovalID = b.ApprovalID
		INNER JOIN MsUsers AS c WITH(NOLOCK) ON
			b.UserEmail = c.UserId
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND c.IsActive = 1
END
GO

SET NOCOUNT OFF
GO           