IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderList'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Order Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderList		
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
					COUNT(DISTINCT a.OrderId)
				FROM
					GA_POrder AS a WITH(NOLOCK)
					LEFT JOIN GA_POrderDtl AS b WITH(NOLOCK) ON
						a.OrderId = b.OrderId
					LEFT JOIN GA_PORequest AS c WITH(NOLOCK) ON
						b.RequestId = c.RequestId
					INNER JOIN GA_Supplier AS d WITH(NOLOCK) ON
						a.SupplierCode = d.SupplierCode
					INNER JOIN MsCurrency AS e WITH(NOLOCK) ON
						a.CurrencyCode = e.CurrencyCode
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
						SELECT DISTINCT TOP ' + CONVERT(VARCHAR,@LastRec) + '
							a.OrderId,
							a.OrderDate,
							a.SupplierCode,
							d.SupplierName,
							a.CurrencyCode,
							e.CurrencyName,
							a.OfferFrom,
							a.OfferNo,
							a.OfferDate,
							a.PIC,
							ISNULL(a.Total,0) AS Total,
							a.DeliveryDate,
							a.Status
						FROM
							GA_POrder AS a WITH(NOLOCK)
							LEFT JOIN GA_POrderDtl AS b WITH(NOLOCK) ON
								a.OrderId = b.OrderId
							LEFT JOIN GA_PORequest AS c WITH(NOLOCK) ON
								b.RequestId = c.RequestId
							INNER JOIN GA_Supplier AS d WITH(NOLOCK) ON
								a.SupplierCode = d.SupplierCode
							INNER JOIN MsCurrency AS e WITH(NOLOCK) ON
								a.CurrencyCode = e.CurrencyCode
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.OrderId
							DESC
					) AS Qry1
					ORDER BY
						OrderId
						ASC
				) AS Qry2
				ORDER BY
					OrderId
					DESC'		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  