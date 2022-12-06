 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemList'
	DROP PROCEDURE [dbo].[spGAItemList]
END
GO

PRINT 'CREATE PROCEDURE spGAItemList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show GA Item Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemList		
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
					GA_Item AS a WITH(NOLOCK)
					INNER JOIN GA_ItemType AS b WITH(NOLOCK) ON
						a.ItemTypeCode = b.ItemTypeCode
					INNER JOIN GA_ItemGroup AS c WITH(NOLOCK) ON
						b.ItemGroupCode = c.ItemGroupCode
					INNER JOIN GA_ItemCategory AS d WITH(NOLOCK) ON
						c.ItemCategoryCode = d.ItemCategoryCode
					INNER JOIN MsMeasurement AS e WITH(NOLOCK) ON
						b.MeasurementCode = e.MeasurementCode
					LEFT JOIN MsBranch AS f WITH(NOLOCK) ON
						a.BranchId = f.BranchId
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
							a.*,
							b.ItemTypeName,
							c.ItemGroupName,
							d.ItemCategoryName,
							e.MeasurementCode,
							ISNULL(f.BranchName,''Warehouse'') AS BranchName
						FROM
							GA_Item AS a WITH(NOLOCK)
							INNER JOIN GA_ItemType AS b WITH(NOLOCK) ON
								a.ItemTypeCode = b.ItemTypeCode
							INNER JOIN GA_ItemGroup AS c WITH(NOLOCK) ON
								b.ItemGroupCode = c.ItemGroupCode
							INNER JOIN GA_ItemCategory AS d WITH(NOLOCK) ON
								c.ItemCategoryCode = d.ItemCategoryCode
							INNER JOIN MsMeasurement AS e WITH(NOLOCK) ON
								b.MeasurementCode = e.MeasurementCode
							LEFT JOIN MsBranch AS f WITH(NOLOCK) ON
								a.BranchId = f.BranchId
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ItemCode
							ASC
					) AS Qry1
					ORDER BY
						ItemCode
						DESC
				) AS Qry2
				ORDER BY
					ItemCode
					ASC'
						
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO     