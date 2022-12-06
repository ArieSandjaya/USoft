IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedDetailDelete'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete GA Purchase Received Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedDetailDelete
	@pivchReceivedDetailID VARCHAR(40),
	@pivchReceivedID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN GAPurchaseReceivedDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
				
		DELETE FROM
			GA_POReceivedDtl
		WHERE
			ReceivedId = @pivchReceivedID
			AND ReceivedDetailId = @pivchReceivedDetailID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN GAPurchaseReceivedDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN GAPurchaseReceivedDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO     