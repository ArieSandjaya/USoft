IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestDetailView'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestDetailView]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestDetailView		
	@pivchRequestDetailID VARCHAR(40),
	@pivchRequestID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.RequestDetailId,
		a.RequestId,
		d.ItemCategoryCode,
		c.ItemGroupCode,
		a.ItemTypeCode,
		a.Quantity,
		c.MeasurementCode,
		a.Price,
		a.Quantity * a.Price AS Total,
		b.Status
	FROM
		GA_PORequestDtl AS a WITH(NOLOCK)
		INNER JOIN GA_PORequest AS b WITH(NOLOCK) ON
			a.RequestId = b.RequestId
		INNER JOIN GA_ItemType AS c WITH(NOLOCK) ON
			a.ItemTypeCode = c.ItemTypeCode
		INNER JOIN GA_ItemGroup AS d WITH(NOLOCK) ON
			c.ItemGroupCode = d.ItemGroupCode
	WHERE
		a.RequestId = @pivchRequestID
		AND a.RequestDetailId = @pivchRequestDetailID
END
GO

SET NOCOUNT OFF
GO   