IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderView'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderView]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Order Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderView		
	@pivchOrderID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
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
		a.Description,
		a.Status,
		ISNULL(a.ApprovalState,0) AS ApprovalState,
		a.created_by AS CreatedBy,
		b.UserName AS CreatedName,
		a.update_by AS UpdateBy,
		c.UserName AS UpdateName
	FROM
		GA_POrder AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
		LEFT JOIN MsUsers AS c WITH(NOLOCK) ON a.update_by = c.UserId
		INNER JOIN GA_Supplier AS d WITH(NOLOCK) ON a.SupplierCode = d.SupplierCode
		INNER JOIN MsCurrency AS e WITH(NOLOCK) ON a.CurrencyCode = e.CurrencyCode
	WHERE
		a.OrderId = @pivchOrderID
END
GO

SET NOCOUNT OFF
GO   