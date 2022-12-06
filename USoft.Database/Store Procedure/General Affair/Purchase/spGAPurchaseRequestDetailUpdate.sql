IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestDetailUpdate'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestDetailUpdate
	@pivchRequestDetailID VARCHAR(40),
	@pivchRequestID VARCHAR(30),
	@pivchItemTypeCode VARCHAR(10),
	@pidblQuantity FLOAT,
	@pimonPrice MONEY,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseRequestDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
		
		UPDATE GA_PORequestDtl
		SET
			ItemTypeCode = @pivchItemTypeCode,
			Quantity = @pidblQuantity,
			Price = @pimonPrice,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			RequestDetailId = @pivchRequestDetailID
			AND RequestId = @pivchRequestID
			
		IF (@@ROWCOUNT = 0)
		BEGIN
			SET @ErrMsg = 'Invalid Detail No. ' + @pivchRequestDetailID + ' - Request No. ' + @pivchRequestID
			GOTO ExitSP
		END
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
		SELECT
			@TotalPrice = SUM(Quantity * Price)
		FROM
			GA_PORequestDtl WITH(NOLOCK)
		WHERE
			RequestId = @pivchRequestID
		GROUP BY
			RequestId
			
		UPDATE
			GA_PORequest
		SET
			Total = @TotalPrice
		WHERE
			RequestId = @pivchRequestID
		
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN PurchaseRequestDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseRequestDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO  