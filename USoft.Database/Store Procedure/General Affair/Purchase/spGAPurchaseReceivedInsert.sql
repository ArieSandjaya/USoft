IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk GA Insert Purchase Received Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedInsert
	@povchReceivedID VARCHAR(30) OUTPUT,
	@pidtmReceivedDate DATETIME,
	@pivchOrderID VARCHAR(30),
	@pivchPIC VARCHAR(100),
	@pivchDescription VARCHAR(255),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseReceivedInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
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
		
		SELECT @povchReceivedID = dbo.fnGenGAPurchaseReceivedNo()
		
		INSERT INTO GA_POReceived (
			ReceivedId,
			ReceivedDate,
			OrderId,
			PIC,
			Description,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			@povchReceivedID,
			@pidtmReceivedDate,
			@pivchOrderID,
			@pivchPIC,
			@pivchDescription,
			'D',
			0,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseReceivedInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseReceivedInsert
	END
END
GO

SET NOCOUNT OFF
GO    