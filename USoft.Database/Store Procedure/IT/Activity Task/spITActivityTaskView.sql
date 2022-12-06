IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityTaskView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityTaskView'
	DROP PROCEDURE [dbo].[spITActivityTaskView]
END
GO

PRINT 'CREATE PROCEDURE spITActivityTaskView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityTaskView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityTaskView		
	@pivchActivityNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ActivityNo,
		a.ActivityDate,
		a.ProblemTypeCode,
		e.ProblemTypeName,
		a.ItemTypeCode,
		b.ItemTypeName,
		a.BranchId,
		c.BranchName,
		a.RequestBy,
		--a.Email,
		a.DepartementCode,
		d.DepartementName,
		a.Description,
		a.Status,
		a.Priority,
		a.PIC,
		a.TerminatedBy,
		a.IsActive,
		a.ApprovalState
	FROM
		IT_ActivityTask AS a WITH(NOLOCK)
		LEFT JOIN IT_ItemType AS b WITH(NOLOCK) ON
			a.ItemTypeCode = b.ItemTypeCode
		INNER JOIN MsBranch AS c WITH(NOLOCK) ON
			a.BranchId = c.BranchId
		LEFT JOIN MsDepartement AS d WITH(NOLOCK) ON
			a.DepartementCode = d.DepartementCode
		INNER JOIN IT_ProblemType AS e WITH(NOLOCK) ON
			a.ProblemTypeCode = e.ProblemTypeCode
	WHERE
		a.ActivityNo = @pivchActivityNo
END
GO

SET NOCOUNT OFF
GO    