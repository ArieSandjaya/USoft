IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderDetailDelete'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete GA Purchase Order Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderDetailDelete
	@pivchOrderDetailID VARCHAR(40),
	@pivchOrderID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAPurchaseOrderDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
				
		DELETE FROM
			GA_POrderDtl
		WHERE
			OrderId = @pivchOrderID
			AND OrderDetailId = @pivchOrderDetailID
		
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
			
	COMMIT TRAN GAPurchaseOrderDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAPurchaseOrderDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO    