IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemTypeList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemTypeList'
	DROP PROCEDURE [dbo].[spGAItemTypeList]
END
GO

PRINT 'CREATE PROCEDURE spGAItemTypeList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemTypeList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show GA Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemTypeList		
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
					GA_ItemType AS a WITH(NOLOCK) 
					INNER JOIN GA_ItemGroup AS b WITH(NOLOCK) ON
						a.ItemGroupCode = b.ItemGroupCode
					INNER JOIN GA_ItemCategory AS c WITH(NOLOCK) ON
						b.ItemCategoryCode = c.ItemCategoryCode
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
							a.ItemTypeCode,
							a.ItemTypeName,
							a.ItemGroupCode,
							b.ItemGroupName,
							b.ItemCategoryCode,
							c.ItemCategoryName,
							a.MeasurementCode,
							a.IsActive
						FROM
							GA_ItemType AS a WITH(NOLOCK) 
							INNER JOIN GA_ItemGroup AS b WITH(NOLOCK) ON
								a.ItemGroupCode = b.ItemGroupCode
							INNER JOIN GA_ItemCategory AS c WITH(NOLOCK) ON
								b.ItemCategoryCode = c.ItemCategoryCode
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ItemTypeCode
							ASC
					) AS Qry1
					ORDER BY
						ItemTypeCode
						DESC
				) AS Qry2
				ORDER BY
					ItemTypeCode
					ASC'
						
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO       