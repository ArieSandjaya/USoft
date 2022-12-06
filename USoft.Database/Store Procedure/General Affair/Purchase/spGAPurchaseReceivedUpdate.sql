IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedUpdate'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk GA Update Purchase Received Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedUpdate
	@pivchReceivedID VARCHAR(30),
	@pidtmReceivedDate DATETIME,
	@pivchOrderID VARCHAR(30),
	@pivchPIC VARCHAR(100),
	@pivchDescription VARCHAR(255),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseReceivedUpdate
		DECLARE
			@ErrMsg VARCHAR(2000),
			@OldOrderID VARCHAR(30)
				
		--* Validation
		IF (
			NOT EXISTS (
				SELECT ''
				FROM GA_POrder WITH(NOLOCK)
				WHERE
					OrderId = @pivchOrderID
					AND Status = 'A'
					AND IsReceived = 0
			)
		)
		BEGIN
			SET @ErrMsg = 'Invalid Order ID'
			GOTO ExitSP	
		END
		
		SELECT
			@OldOrderID = OrderId
		FROM
			GA_POReceived
		WHERE
			ReceivedId = @pivchReceivedID
		
		IF(@OldOrderID <> @pivchOrderID)
		BEGIN
			DELETE FROM GA_POReceivedDtl
			WHERE ReceivedId = @pivchReceivedID
		END
		
		UPDATE GA_POReceived
		SET
			ReceivedDate = @pidtmReceivedDate,
			OrderId = @pivchOrderId,
			PIC = @pivchPIC,
			Description = @pivchDescription,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ReceivedId = @pivchReceivedID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseReceivedUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseReceivedUpdate
	END
END
GO

SET NOCOUNT OFF
GO     