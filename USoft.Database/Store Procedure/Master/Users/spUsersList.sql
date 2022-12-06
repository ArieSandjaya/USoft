 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersList'
	DROP PROCEDURE [dbo].[spUsersList]
END
GO

PRINT 'CREATE PROCEDURE spUsersList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersList		
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
					MsUsers AS a WITH(NOLOCK)
					INNER JOIN MsBranch AS b WITH(NOLOCK) ON (a.BranchId = b.BranchId)
					LEFT JOIN MsPrivilege AS c WITH(NOLOCK) ON (a.PrivilegeCode = c.PrivilegeCode)
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
							a.UserId,
							a.Pass,
							a.UserName,
							a.UgetsValue,
							a.BranchId,
							a.GroupId,
							a.PriviledgeCode,
							a.PrivilegeCode,
							c.PrivilegeName,
							a.IsActive,
							a.IsAllBranch,
							a.CanEditOpex,
							a.Email,
							a.CanSendMail,
							a.ChangePass,
							b.BranchName
						FROM
							MsUsers AS a WITH(NOLOCK)
							INNER JOIN MsBranch AS b WITH(NOLOCK) ON (a.BranchId = b.BranchId)
							LEFT JOIN MsPrivilege AS c WITH(NOLOCK) ON (a.PrivilegeCode = c.PrivilegeCode)
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.UserId
							ASC
					) AS Qry1
					ORDER BY
						UserId
						DESC
				) AS Qry2
				ORDER BY
					UserId
					ASC'		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  