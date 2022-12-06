IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestDetailInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestDetailInsert
	@pivchRequestID VARCHAR(30),
	@pivchItemTypeCode VARCHAR(10),
	@pidblQuantity FLOAT,
	@pimonPrice MONEY,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseRequestDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY,
			@povchRequestDetailID VARCHAR(40)
		
		SELECT @povchRequestDetailID = dbo.fnGenGAPurchaseRequestDetailNo(@pivchRequestID)
		
		INSERT INTO GA_PORequestDtl (
			RequestDetailId,
			RequestId,
			ItemTypeCode,
			Quantity,
			Price,
			created_date,
			created_by
		)
		SELECT
			@povchRequestDetailID,
			@pivchRequestID,
			@pivchItemTypeCode,
			@pidblQuantity,
			@pimonPrice,
			GETDATE(),
			@pivchInputID
			
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
				
	COMMIT TRAN PurchaseRequestDetailInsert
	RETURN --@povchRequestDetailID
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseRequestDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO  