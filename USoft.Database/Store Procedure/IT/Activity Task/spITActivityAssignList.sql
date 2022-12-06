IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityAssignList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityAssignList'
	DROP PROCEDURE [dbo].[spITActivityAssignList]
END
GO

PRINT 'CREATE PROCEDURE spITActivityAssignList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityAssignList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Assign Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityAssignList
	@pivchActivityNo VARCHAR(12),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.AssignID,
					a.AssignFrom,
					b.UserName AS FromName,
					a.AssignTo,
					c.UserName AS ToName,
					a.DateAssign,
					a.StatusAssign,
					CASE
						WHEN a.StatusAssign = 0 THEN ''Re-Open By '' + b.UserName
						WHEN a.StatusAssign = 1 THEN ''Assign To '' + c.UserName
						WHEN a.StatusAssign = 2 THEN ''Solved By '' + b.UserName
						WHEN a.StatusAssign = 3 THEN ''Closed By '' + b.UserName
						WHEN a.StatusAssign = 4 THEN ''Done By '' + b.UserName
					END AS StatusActivity,
					a.Description,
					a.ReAssignID
				FROM
					IT_ActivityAssign AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.AssignFrom = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.AssignTo = c.UserId
				WHERE
					a.ActivityNo = ''' + @pivchActivityNo + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY a.DateAssign DESC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   