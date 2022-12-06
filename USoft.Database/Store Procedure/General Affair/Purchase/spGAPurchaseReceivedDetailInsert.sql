IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedDetailInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Received Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedDetailInsert
	@pivchReceivedID VARCHAR(30),
	@pivchRequestDetailID VARCHAR(40),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseReceivedDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@povchReceivedDetailId VARCHAR(40),
			@OrderId VARCHAR(30),
			@Status CHAR(1),
			@IsReceived BIT,
			@TotalPrice MONEY
			
		-- Validation
		IF (
			EXISTS (
				SELECT ''
				FROM GA_POReceivedDtl WITH(NOLOCK)
				WHERE
					ReceivedId = @pivchReceivedID
					AND RequestDetailId = @pivchRequestDetailID
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Order already insert'
			GOTO ExitSP
		END
		
		SELECT
			@OrderId = ISNULL(a.OrderId,''),
			@Status = a.Status,
			@IsReceived = ISNULL(a.IsReceived,0)
		FROM
			GA_POrder AS a WITH(NOLOCK)
			INNER JOIN GA_POReceived AS b WITH(NOLOCK) ON
				a.OrderId = b.OrderId
		WHERE
			b.ReceivedId = @pivchReceivedID
			
		IF (@@ROWCOUNT = 0)
		BEGIN
			SET @ErrMsg = 'Order ID ' + @OrderId + ' is invalid'
			GOTO ExitSP
		END
		
		IF (@IsReceived = 1)
		BEGIN
			SET @ErrMsg = 'Order ID ' + @OrderId + ' already received'
			GOTO ExitSP
		END
		
		IF (@Status <> 'A')
		BEGIN
			SET @ErrMsg = 'Order ID ' + @OrderId + ' has not been Approve'
			GOTO ExitSP
		END
		
		SELECT @povchReceivedDetailId = dbo.fnGenGAPurchaseReceivedDetailNo(@pivchReceivedID)
		
		INSERT INTO GA_POReceivedDtl (
			ReceivedDetailId,
			ReceivedId,
			RequestDetailId,
			Quantity,
			created_date,
			created_by
		)
		SELECT
			@povchReceivedDetailId,
			@pivchReceivedID,
			@pivchRequestDetailID,
			0,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN PurchaseReceivedDetailInsert
	RETURN --@povchReceivedDetailId
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseReceivedDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO 