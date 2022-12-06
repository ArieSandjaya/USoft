IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedList'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Received Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedList		
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
					GA_POReceived AS a WITH(NOLOCK)
					INNER JOIN GA_POrder AS b WITH(NOLOCK) ON
						a.OrderId = b.OrderId
					INNER JOIN GA_Supplier AS c WITH(NOLOCK) ON
						b.SupplierCode = c.SupplierCode
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
							a.ReceivedId,
							a.ReceivedDate,
							a.OrderId,
							b.SupplierCode,
							c.SupplierName,
							a.PIC,
							a.Status
						FROM
							GA_POReceived AS a WITH(NOLOCK)
							INNER JOIN GA_POrder AS b WITH(NOLOCK) ON
								a.OrderId = b.OrderId
							INNER JOIN GA_Supplier AS c WITH(NOLOCK) ON
								b.SupplierCode = c.SupplierCode
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ReceivedId
							DESC
					) AS Qry1
					ORDER BY
						ReceivedId
						ASC
				) AS Qry2
				ORDER BY
					ReceivedId
					DESC'		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   