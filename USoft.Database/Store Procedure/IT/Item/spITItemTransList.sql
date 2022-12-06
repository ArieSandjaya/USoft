IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransList'
	DROP PROCEDURE [dbo].[spITItemTransList]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show data Item Tranfer Hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemTransList]		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000),
			@sqlWhere VARCHAR(8000)
	
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
					IT_ItemTrans AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON b.BranchId = a.BranchId_From
					LEFT JOIN MsBranch AS c WITH(NOLOCK) ON c.BranchId = a.BranchId_To
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
							a.ITItemTransCode,
							ISNULL(b.BranchName,''Warehouse'') AS BranchFrom,
							ISNULL(c.BranchName,''Warehouse'') AS BranchTo,
							a.DateTrans,
							a.Status
						FROM
							IT_ItemTrans AS a WITH(NOLOCK)
							LEFT JOIN MsBranch AS b WITH(NOLOCK) ON b.BranchId = a.BranchId_From
							LEFT JOIN MsBranch AS c WITH(NOLOCK) ON c.BranchId = a.BranchId_To 		
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ITItemTransCode
							ASC
					) AS Qry1
					ORDER BY
						ITItemTransCode
						DESC
				) AS Qry2
				ORDER BY
					ITItemTransCode
					ASC'
		
	PRINT @sql
	EXEC(@sql)
	
END
GO

SET NOCOUNT OFF
GO  