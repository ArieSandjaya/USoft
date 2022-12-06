IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedDetailList'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedDetailList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Received Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedDetailList		
	@pivchReceivedID VARCHAR(30),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					ROW_NUMBER() OVER(ORDER BY a.ReceivedDetailId ASC) AS ''No'',
					a.ReceivedDetailId,
					c.*,
					(c.Quantity * c.Price) AS Total,
					(
						SELECT
							ISNULL(SUM(x.Quantity),0)
						FROM
							GA_POReceivedDtl AS x WITH(NOLOCK)
							INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
								x.ReceivedId = y.ReceivedId
						WHERE
							y.Status = ''A''
							AND x.RequestDetailId = a.RequestDetailId
							AND y.OrderId = b.OrderId
					) AS CurrentQty,
					a.Quantity AS ReceivedQty,
					d.ItemTypeName,
					e.ItemGroupName,
					d.MeasurementCode
				FROM
					GA_POReceivedDtl AS a WITH(NOLOCK)
					INNER JOIN GA_POReceived AS b WITH(NOLOCK) ON
						(a.ReceivedId = b.ReceivedId)
					INNER JOIN GA_PORequestDtl AS c WITH(NOLOCK) ON 
						(a.RequestDetailId = c.RequestDetailId)
					INNER JOIN GA_ItemType AS d WITH(NOLOCK) ON 
						(c.ItemTypeCode = d.ItemTypeCode)
					INNER JOIN GA_ItemGroup AS e WITH(NOLOCK) ON 
						(d.ItemGroupCode = e.ItemGroupCode)
					INNER JOIN MsMeasurement AS f WITH(NOLOCK) ON 
						(d.MeasurementCode = f.MeasurementCode)
				WHERE
					(a.ReceivedId = ''' + @pivchReceivedID + ''')'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   