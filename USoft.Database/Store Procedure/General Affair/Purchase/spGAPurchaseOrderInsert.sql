IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk GA Insert Purchase Order Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderInsert
	@povchOrderID VARCHAR(30) OUTPUT,
	@pidtmOrderDate DATETIME,
	@pivchSupplierCode VARCHAR(5),
	@pivchCurrencyCode VARCHAR(3),
	@pivchPIC VARCHAR(100),
	@pidtmDeliveryDate DATETIME,
	@pivchOfferFrom VARCHAR(50),
	@pivchOfferNo VARCHAR(100),
	@pidtmOfferDate DATETIME,
	@pivchDescription VARCHAR(255),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseOrderInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		--* Default Value
		IF CONVERT(VARCHAR(8),@pidtmDeliveryDate,112) = '17530101'
			SET @pidtmDeliveryDate = NULL

		IF CONVERT(VARCHAR(8),@pidtmOfferDate,112) = '17530101'
			SET @pidtmOfferDate = NULL

		--* Validation
		IF (@pidtmDeliveryDate IS NOT NULL)
			AND
			(CONVERT(VARCHAR(8),@pidtmDeliveryDate,112) > CONVERT(VARCHAR(8),@pidtmOrderDate,112))
		BEGIN
			SET @ErrMsg = 'Delivery Date (' + CONVERT(VARCHAR(10),@pidtmDeliveryDate,105) + ') must bigger or equivalent than Order Date (' + CONVERT(VARCHAR(10),@pidtmOrderDate,105) + ')'
			GOTO ExitSP	
		END
		
		SELECT @povchOrderID = dbo.fnGenGAPurchaseOrderNo()
		
		INSERT INTO GA_POrder (
			OrderId,
			OrderDate,
			SupplierCode,
			CurrencyCode,
			PIC,
			DeliveryDate,
			OfferFrom,
			OfferNo,
			OfferDate,
			Description,
			IsReceived,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			@povchOrderID,
			@pidtmOrderDate,
			@pivchSupplierCode,
			@pivchCurrencyCode,
			@pivchPIC,
			@pidtmDeliveryDate,
			@pivchOfferFrom,
			@pivchOfferNo,
			@pidtmOfferDate,
			@pivchDescription,
			0,
			'D',
			0,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseOrderInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseOrderInsert
	END
END
GO

SET NOCOUNT OFF
GO   