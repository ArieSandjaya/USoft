IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedDetailUpdate'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Purchase Received Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedDetailUpdate
	@pivchReceivedID VARCHAR(30),
	@pivchReceivedDetailID VARCHAR(40),
	@pidblQuantity FLOAT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseReceivedDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000),
			@OrderID VARCHAR(30),
			@RequestDetailID VARCHAR(40),
			@RequestQty FLOAT,
			@RequestID VARCHAR(30),
			@ItemGroupName VARCHAR(100),
			@ItemTypeName VARCHAR(100),
			@CurrentQty FLOAT
			
		SELECT
			@OrderID = OrderID
		FROM
			GA_POReceived WITH(NOLOCK)
		WHERE
			ReceivedId = @pivchReceivedID
			
		-- Validation
		SELECT
			@RequestID = a.RequestId,
			@ItemGroupName = d.ItemGroupName,
			@ItemTypeName = c.ItemTypeName,
			@RequestQty = a.Quantity,
			@CurrentQty = (
							SELECT
								ISNULL(SUM(x.Quantity),0)
							FROM
								GA_POReceivedDtl AS x WITH(NOLOCK)
								INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
									x.ReceivedId = y.ReceivedId
							WHERE
								x.RequestDetailId = a.RequestDetailId
								AND y.Status = 'A'

						)
		FROM
			GA_PORequestDtl AS a WITH(NOLOCK)
			INNER JOIN GA_POReceivedDtl AS b WITH(NOLOCK) ON
				a.RequestDetailId = b.RequestDetailId
			INNER JOIN GA_ItemType AS c WITH(NOLOCK) ON
				a.ItemTypeCode = c.ItemTypeCode
			INNER JOIN GA_ItemGroup AS d WITH(NOLOCK) ON
				c.ItemGroupCode = d.ItemGroupCode
		WHERE
			b.ReceivedDetailID = @pivchReceivedDetailID
		
		IF(
			(@RequestQty < (@CurrentQty + @pidblQuantity))
			OR
			(@pidblQuantity <= 0)
		)
		BEGIN
			SET @ErrMsg = 'Invalid Item Quantity ' + @RequestID + ' - ' + @ItemGroupName + ' - ' + @ItemTypeName + ', Request Quantity = ' + CONVERT(VARCHAR,@RequestQty) + ', Outstanding Received Quantity = ' + CONVERT(VARCHAR,@CurrentQty) + ', Received Quantity = ' + CONVERT(VARCHAR,@pidblQuantity)
			GOTO ExitSP
		END
							
		UPDATE
			GA_POReceivedDtl
		SET
			Quantity = @pidblQuantity,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ReceivedID = @pivchReceivedID
			AND ReceivedDetailID = @pivchReceivedDetailID
			
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN PurchaseReceivedDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseReceivedDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO  