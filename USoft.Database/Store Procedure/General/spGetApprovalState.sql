IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetApprovalState]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetApprovalState'
	DROP PROCEDURE [dbo].[spGetApprovalState]
END
GO

PRINT 'CREATE PROCEDURE spGetApprovalState'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetApprovalState
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Page Approval
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetApprovalState
	@piintMenuId INT,
	@piintState INT,
	@pivchUserId VARCHAR(50),
	@piintDataBranchId INT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ApprovalState BIT, @MaxState INT
	
	SELECT
		@MaxState = MAX(State)
	FROM
		MsMappingApproval WITH(NOLOCK)
	WHERE
		MenuId = @piintMenuId

	SELECT DISTINCT
		@ApprovalState = convert(bit,1)
	FROM (
			SELECT
				a.UserIdApproval
			FROM
				MsMappingApproval AS a WITH(NOLOCK)
				INNER JOIN MsUsers AS b WITH(NOLOCK) ON
					a.UserIdApproval = b.UserId
				INNER JOIN MsPrivilege AS c WITH(NOLOCK) ON
					b.PrivilegeCode = c.PrivilegeCode
			WHERE
				a.IsActive = 1
				AND b.IsActive = 1
				AND a.MenuId = @piintMenuId
				AND a.State = @piintState
				AND a.UserIdApproval = @pivchUserId
				AND ((ISNULL(a.DepartementCode,0) = 0) OR (a.DepartementCode = c.DepartementCode))
				AND (
					((a.IsBranch = 1) AND (@piintDataBranchId = b.BranchId))	-- Specify Branch
					OR
					(ISNULL(a.IsBranch,0) = 0)								-- All Branch
					OR
					(b.IsAllBranch = 1)										-- This User have All Branch Permission
				)

			UNION

			SELECT
				b.UserId AS UserIdApproval
			FROM
				MsMappingApproval AS a WITH(NOLOCK)
				INNER JOIN MsUsers AS b WITH(NOLOCK) ON
					a.ParentCode = b.PrivilegeCode
				INNER JOIN MsPrivilege AS c WITH(NOLOCK) ON
					b.PrivilegeCode = c.PrivilegeCode
			WHERE
				a.IsActive = 1
				AND b.IsActive = 1
				AND a.MenuId = @piintMenuId
				AND a.State = @piintState
				AND a.UserIdApproval IS NULL
				AND ((ISNULL(a.DepartementCode,0) = 0) OR (a.DepartementCode = c.DepartementCode))
				AND (
					((a.IsBranch = 1) AND (@piintDataBranchId = b.BranchId))	-- Specify Branch
					OR
					(ISNULL(a.IsBranch,0) = 0)								-- All Branch
					OR
					(b.IsAllBranch = 1)										-- This User have All Branch Permission
				)
		) AS Qry
	WHERE
		Qry.UserIdApproval = @pivchUserId
		
	SELECT
		ISNULL(@ApprovalState,0) AS ApprovalState,
		ISNULL(@MaxState,-1) AS MaxState
END
GO

SET NOCOUNT OFF
GO          