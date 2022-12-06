IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyInsert'
	DROP PROCEDURE [dbo].[spCurrencyInsert]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyInsert
	@pivchCurrencyCode VARCHAR(3),
	@pivchCurrencyName VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN CurrencyInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsCurrency WITH(NOLOCK) 
				WHERE CurrencyCode =  @pivchCurrencyCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Currency Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsCurrency (
				CurrencyCode,
				CurrencyName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchCurrencyCode,
				@pivchCurrencyName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN CurrencyInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN CurrencyInsert
	END
END
GO

SET NOCOUNT OFF
GO      