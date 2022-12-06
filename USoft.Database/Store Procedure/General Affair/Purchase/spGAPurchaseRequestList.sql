IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestList'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Request Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestList		
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
					GA_PORequest AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
					INNER JOIN MsCurrency AS c WITH(NOLOCK) ON (a.CurrencyCode = c.CurrencyCode)
					INNER JOIN MsBranch AS d WITH(NOLOCK) ON (a.BranchId = d.BranchId)
					LEFT JOIN GA_Supplier AS e WITH(NOLOCK) ON (a.SupplierCode = e.SupplierCode)
					INNER JOIN GA_ItemCategory AS f WITH(NOLOCK) ON (a.ItemCategoryCode = f.ItemCategoryCode)
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
							a.RequestId,
							a.RequestDate,
							a.Status,
							b.UserName,
							d.BranchName,
							e.SupplierName,
							ISNULL(a.Total,0) AS Total,
							a.CurrencyCode,
							a.ItemCategoryCode,
							f.ItemCategoryName
						FROM
							GA_PORequest AS a WITH(NOLOCK)
							INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
							INNER JOIN MsCurrency AS c WITH(NOLOCK) ON (a.CurrencyCode = c.CurrencyCode)
							INNER JOIN MsBranch AS d WITH(NOLOCK) ON (a.BranchId = d.BranchId)
							LEFT JOIN GA_Supplier AS e WITH(NOLOCK) ON (a.SupplierCode = e.SupplierCode)
							INNER JOIN GA_ItemCategory AS f WITH(NOLOCK) ON (a.ItemCategoryCode = f.ItemCategoryCode)
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.RequestId
							DESC
					) AS Qry1
					ORDER BY
						RequestId
						ASC
				) AS Qry2
				ORDER BY
					RequestId
					DESC'		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 