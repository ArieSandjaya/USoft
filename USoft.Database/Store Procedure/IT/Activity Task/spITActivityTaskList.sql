IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityTaskList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityTaskList'
	DROP PROCEDURE [dbo].[spITActivityTaskList]
END
GO

PRINT 'CREATE PROCEDURE spITActivityTaskList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityTaskList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityTaskList		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE
		@sql VARCHAR(8000),
		@sqlWhere VARCHAR(8000)
	
	IF (@pivchWhereBy <> '')
		SET @sqlWhere = ' AND ' + @pivchWhereBy
	
	-- Paging Start
	DECLARE @FirstRec int, @LastRec int
	IF @piintPageNo < 0
		SET @piintPageNo = 0
    SELECT
		@FirstRec = (@piintPageNo - 1) * @piintPageSize + 1,
		@LastRec = (@piintPageNo * @piintPageSize)
	
	CREATE TABLE #TotalRecord (
		TotalRecords INT
	)
	
	SET @sql = 'INSERT INTO #TotalRecord (TotalRecords)
				SELECT
					COUNT(*)
				FROM
							IT_ActivityTask AS a WITH(NOLOCK)
							LEFT JOIN (
								SELECT
									x.*
								FROM
									IT_ActivityAssign AS x WITH(NOLOCK)
									INNER JOIN (
										SELECT
											ActivityNo,
											MAX(DateAssign) AS DateAssign
										FROM
											IT_ActivityAssign WITH(NOLOCK)
										GROUP BY
											ActivityNo
									) AS y ON
										x.ActivityNo = y.ActivityNo
										AND x.DateAssign = y.DateAssign
							) AS b ON
								a.ActivityNo = b.ActivityNo

							LEFT JOIN IT_ItemType AS c WITH(NOLOCK) ON
								a.ItemTypeCode = c.ItemTypeCode
							INNER JOIN MsBranch AS d WITH(NOLOCK) ON
								a.BranchId = d.BranchId
							LEFT JOIN MsDepartement AS e WITH(NOLOCK) ON
								a.DepartementCode = e.DepartementCode

							-- Last Update
							INNER JOIN MsUsers AS f WITH(NOLOCK) ON
								a.created_by = f.UserId
							LEFT JOIN MsUsers AS g WITH(NOLOCK) ON
								a.update_by = g.UserId

							-- Assign To
							--LEFT JOIN MsUsers AS h WITH(NOLOCK) ON
							--	b.AssignTo = h.UserId
							
							-- PIC
							LEFT JOIN MsUsers AS i WITH(NOLOCK) ON
								a.PIC = i.UserId
							
							--Terminated By
							LEFT JOIN MsUsers AS j WITH(NOLOCK) ON
								a.TerminatedBy = j.UserId
								
							--Problem Type	
							INNER JOIN IT_ProblemType AS k WITH(NOLOCK) ON
								a.ProblemTypeCode = k.ProblemTypeCode
								
						WHERE a.IsActive = 1
				' + ISNULL(@sqlWhere,'')
				
	EXEC(@sql)
	
	SELECT @pointTotalData = TotalRecords from #TotalRecord

    DROP TABLE #TotalRecord

	SELECT @pointTotalPage = (@pointTotalData / @piintPageSize) + CASE WHEN @pointTotalData % @piintPageSize > 0 THEN 1 ELSE 0 END
	
	IF ((@piintPageNo * @piintPageSize) > @pointTotalData) -- Get Last Data
		SELECT @piintPageSize = CASE WHEN @pointTotalPage < @piintPageNo THEN 0 ELSE (@pointTotalData - ((@piintPageNo - 1) * @piintPageSize)) END			
	-- Paging End			
				
	SET @sql = 'SELECT TOP 100 PERCENT *
				FROM (	
					SELECT TOP ' + convert(varchar,@piintPageSize) + ' * 
					FROM (
						SELECT TOP ' + CONVERT(VARCHAR,@LastRec) + '
							a.ActivityNo,
							a.ActivityDate,
							a.RequestBy,
							a.BranchId,
							d.BranchName,
							--a.Email,
							a.DepartementCode,
							e.DepartementName,
							a.ProblemTypeCode,
							k.ProblemTypeName,
							a.ItemTypeCode,
							c.ItemTypeName,
							a.Description,
							a.IsActive,
							a.Status,
							a.Priority,
							i.UserName AS PIC,
							j.UserName AS TerminatedBy,
							a.created_date,
							a.update_date,
							b.AssignID,
							b.AssignTo,
							b.AssignFrom,
							b.DateAssign,
							b.StatusAssign,
							CASE
								WHEN a.update_by IS NULL THEN f.UserName
								ELSE g.UserName
							END AS LastUpdateBy
							--h.UserName AS AssignToName
						FROM
							IT_ActivityTask AS a WITH(NOLOCK)
							LEFT JOIN (
								SELECT
									x.*
								FROM
									IT_ActivityAssign AS x WITH(NOLOCK)
									INNER JOIN (
										SELECT
											ActivityNo,
											MAX(DateAssign) AS DateAssign
										FROM
											IT_ActivityAssign WITH(NOLOCK)
										GROUP BY
											ActivityNo
									) AS y ON
										x.ActivityNo = y.ActivityNo
										AND x.DateAssign = y.DateAssign
							) AS b ON
								a.ActivityNo = b.ActivityNo

							LEFT JOIN IT_ItemType AS c WITH(NOLOCK) ON
								a.ItemTypeCode = c.ItemTypeCode
							INNER JOIN MsBranch AS d WITH(NOLOCK) ON
								a.BranchId = d.BranchId
							LEFT JOIN MsDepartement AS e WITH(NOLOCK) ON
								a.DepartementCode = e.DepartementCode

							-- Last Update
							INNER JOIN MsUsers AS f WITH(NOLOCK) ON
								a.created_by = f.UserId
							LEFT JOIN MsUsers AS g WITH(NOLOCK) ON
								a.update_by = g.UserId

							-- Assign To
							--LEFT JOIN MsUsers AS h WITH(NOLOCK) ON
							--	b.AssignTo = h.UserId
							
							-- PIC
							LEFT JOIN MsUsers AS i WITH(NOLOCK) ON
								a.PIC = i.UserId
							
							--Terminated By
							LEFT JOIN MsUsers AS j WITH(NOLOCK) ON
								a.TerminatedBy = j.UserId
								
							--Problem Type	
							INNER JOIN IT_ProblemType AS k WITH(NOLOCK) ON
								a.ProblemTypeCode = k.ProblemTypeCode
								
						WHERE a.IsActive = 1		
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ActivityNo
							DESC
					) AS Qry1
					ORDER BY
						ActivityNo
						ASC
				) AS Qry2
				ORDER BY
					ActivityNo
					DESC'			
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   