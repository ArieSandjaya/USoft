IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestDetailDelete'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete GA Purchase Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestDetailDelete
	@pivchRequestDetailID VARCHAR(40),
	@pivchRequestID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAPurchaseRequestDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
				
		DELETE FROM
			GA_PORequestDtl
		WHERE
			RequestId = @pivchRequestID
			AND RequestDetailId = @pivchRequestDetailID
		
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
			
	COMMIT TRAN GAPurchaseRequestDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAPurchaseRequestDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO   