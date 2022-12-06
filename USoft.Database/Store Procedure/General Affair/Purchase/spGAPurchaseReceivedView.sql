IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedView'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedView]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Received Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedView		
	@pivchReceivedID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ReceivedId,
		a.ReceivedDate,
		a.OrderId,
		b.OrderDate,
		b.SupplierCode,
		c.SupplierName,
		b.CurrencyCode,
		d.CurrencyName,
		b.OfferFrom,
		b.OfferNo,
		b.OfferDate,
		a.PIC,
		a.Description,
		a.Status,
		ISNULL(a.ApprovalState,0) AS ApprovalState,
		a.created_by AS CreatedBy,
		e.UserName AS CreatedName,
		a.update_by AS UpdateBy,
		f.UserName AS UpdateName
	FROM
		GA_POReceived AS a WITH(NOLOCK)
		INNER JOIN GA_POrder AS b WITH(NOLOCK) ON a.OrderId = b.OrderId
		INNER JOIN GA_Supplier AS c WITH(NOLOCK) ON b.SupplierCode = c.SupplierCode
		INNER JOIN MsCurrency AS d WITH(NOLOCK) ON b.CurrencyCode = d.CurrencyCode
		INNER JOIN MsUsers AS e WITH(NOLOCK) ON a.created_by = e.UserId
		LEFT JOIN MsUsers AS f WITH(NOLOCK) ON a.update_by = f.UserId
	WHERE
		a.ReceivedId = @pivchReceivedID
END
GO

SET NOCOUNT OFF
GO    