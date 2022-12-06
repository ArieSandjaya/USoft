IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyUpdate'
	DROP PROCEDURE [dbo].[spCurrencyUpdate]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyUpdate
	@pivchCurrencyCode VARCHAR(3),
	@pivchCurrencyName VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN CurrencyUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsCurrency
		SET
			CurrencyName = @pivchCurrencyName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			CurrencyCode = @pivchCurrencyCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN CurrencyUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN CurrencyUpdate
	END
END
GO

SET NOCOUNT OFF
GO      