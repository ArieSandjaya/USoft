IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchList'
	DROP PROCEDURE [dbo].[spBranchList]
END
GO

PRINT 'CREATE PROCEDURE spBranchList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchList		
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
					MsBranch a WITH(NOLOCK)
					LEFT JOIN MsBranch b WITH(NOLOCK) ON a.BranchParent = b.BranchId
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
							a.BranchId,
							a.BranchCode,
							a.BranchName,
							CASE a.BranchType
								WHEN ''1'' THEN ''BRANCH''
								ELSE ''SBP''
							END as BranchType,
							b.BranchName as BranchParent,
							a.IsActive
						FROM
							MsBranch a WITH(NOLOCK)
							LEFT JOIN MsBranch b WITH(NOLOCK) ON a.BranchParent = b.BranchId
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.BranchId
							ASC
					) AS Qry1
					ORDER BY
						BranchId
						DESC
				) AS Qry2
				ORDER BY
					BranchId
					ASC'		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO