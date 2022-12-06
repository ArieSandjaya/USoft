IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalList'
	DROP PROCEDURE [dbo].[spMappingApprovalList]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalList		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE
		@sql VARCHAR(2000),
		@sqlWhere VARCHAR(2000)

	IF (@pivchWhereBy <> '')
		SET @sqlWhere = ' WHERE ' + @pivchWhereBy
	
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
					MsMappingApproval AS a WITH(NOLOCK)
					INNER JOIN MsMenu AS b WITH(NOLOCK) ON
						(a.MenuId = b.MenuId)
					LEFT JOIN MsDepartement AS c WITH(NOLOCK) ON
						(a.DepartementCode = c.DepartementCode)
					LEFT JOIN MsPrivilege AS d WITH(NOLOCK) ON
						(a.ParentCode = d.PrivilegeCode)
					LEFT JOIN MsUsers AS e WITH(NOLOCK) ON
						(a.UserIdApproval = e.UserId)
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
							a.ApprovalID,
							a.MenuId,
							a.DepartementCode,
							ISNULL(c.DepartementName,''All Departement'') AS DepartementName,
							a.ParentCode,
							d.PrivilegeName AS ParentName,
							a.UserIdApproval,
							e.UserName AS UserNameApproval,
							a.IsBranch,
							a.State,
							a.StateDescription,
							a.IsActive,
							b.MenuName
						FROM
							MsMappingApproval AS a WITH(NOLOCK)
							INNER JOIN MsMenu AS b WITH(NOLOCK) ON
								(a.MenuId = b.MenuId)
							LEFT JOIN MsDepartement AS c WITH(NOLOCK) ON
								(a.DepartementCode = c.DepartementCode)
							LEFT JOIN MsPrivilege AS d WITH(NOLOCK) ON
								(a.ParentCode = d.PrivilegeCode)
							LEFT JOIN MsUsers AS e WITH(NOLOCK) ON
								(a.UserIdApproval = e.UserId)
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.MenuId, a.State, a.DepartementCode
							ASC
					) AS Qry1
					ORDER BY
						MenuId, State, DepartementCode
						DESC
				) AS Qry2
				ORDER BY
					MenuId, State, DepartementCode
					ASC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  