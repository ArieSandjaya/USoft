IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedDetailView'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedDetailView]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Received Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedDetailView		
	@pivchReceivedDetailID VARCHAR(40),
	@pivchReceivedID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.RequestDetailId,
		c.RequestId,
		f.ItemCategoryCode,
		f.ItemCategoryName,
		e.ItemGroupCode,
		e.ItemGroupName,
		d.ItemTypeCode,
		d.ItemTypeName,
		c.Quantity AS RequestQty,
		(
			SELECT
				ISNULL(SUM(x.Quantity),0)
			FROM
				GA_POReceivedDtl AS x WITH(NOLOCK)
				INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
					x.ReceivedId = y.ReceivedId
			WHERE
				y.Status = 'A'
				AND x.RequestDetailId = a.RequestDetailId
				AND y.OrderId = b.OrderId
		) AS CurrentQty,
		a.Quantity,
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
		INNER JOIN GA_ItemCategory AS f WITH(NOLOCK) ON 
			(e.ItemCategoryCode = f.ItemCategoryCode)
		INNER JOIN MsMeasurement AS g WITH(NOLOCK) ON 
			(d.MeasurementCode = g.MeasurementCode)
	WHERE
		a.ReceivedId = @pivchReceivedID
		AND a.ReceivedDetailId = @pivchReceivedDetailID
END
GO

SET NOCOUNT OFF
GO    