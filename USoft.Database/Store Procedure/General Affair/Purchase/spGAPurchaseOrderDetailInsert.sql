IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderDetailInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Order Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderDetailInsert
	@pivchOrderID VARCHAR(30),
	@pivchRequestID VARCHAR(30),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseOrderDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@povchOrderDetailId VARCHAR(40),
			@OrderId VARCHAR(30),
			@Status CHAR(1),
			@TotalPrice MONEY
			
		-- Validation
		IF (
			EXISTS (
				SELECT ''
				FROM GA_POrderDtl WITH(NOLOCK)
				WHERE
					OrderId = @pivchOrderID
					AND RequestId = @pivchRequestID
			)
		)
		BEGIN
			SET @ErrMsg = 'Request ID ' + @pivchRequestID + ' already insert'
			GOTO ExitSP
		END
		
		SELECT
			@OrderId = ISNULL(OrderId,''),
			@Status = Status
		FROM GA_PORequest WITH(NOLOCK)
		WHERE RequestId = @pivchRequestID
		
		IF (@OrderId <> '')
		BEGIN
			SET @ErrMsg = 'Request ID ' + @pivchRequestID + ' already order with Order ID ' + @OrderId
			GOTO ExitSP
		END
		
		IF (@Status <> 'A')
		BEGIN
			SET @ErrMsg = 'Request ID ' + @pivchRequestID + ' has not been Approve'
			GOTO ExitSP
		END
		
		SELECT @povchOrderDetailId = dbo.fnGenGAPurchaseOrderDetailNo(@pivchOrderID)
		
		INSERT INTO GA_POrderDtl (
			OrderDetailId,
			OrderId,
			RequestId,
			created_date,
			created_by
		)
		SELECT
			@povchOrderDetailId,
			@pivchOrderID,
			@pivchRequestID,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
		SELECT
			@TotalPrice = SUM(Quantity * Price)
		FROM
			GA_PORequestDtl AS a WITH (NOLOCK)
			INNER JOIN GA_POrderDtl AS b WITH(NOLOCK) ON
				a.RequestId = b.RequestId
		WHERE
			b.OrderId = @pivchOrderID
		GROUP BY
			b.OrderId
			
		UPDATE
			GA_POrder
		SET
			Total = @TotalPrice
		WHERE
			OrderId = @pivchOrderID
		
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN PurchaseOrderDetailInsert
	RETURN --@povchOrderDetailId
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseOrderDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO