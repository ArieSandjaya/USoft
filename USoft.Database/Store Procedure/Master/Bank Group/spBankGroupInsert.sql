IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBankGroupInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBankGroupInsert'
	DROP PROCEDURE [dbo].[spBankGroupInsert]
END
GO

PRINT 'CREATE PROCEDURE spBankGroupInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBankGroupInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Bank Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBankGroupInsert
	@pivchBankGroupCode VARCHAR(3),
	@pivchBankGroupName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BankGroupInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsBankGroup WITH(NOLOCK) WHERE BankGroupCode = @pivchBankGroupCode
			)
		)
		BEGIN
			SET @ErrMsg = 'BankGroup Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsBankGroup (
				BankGroupCode,
				BankGroupName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchBankGroupCode,
				@pivchBankGroupName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN BankGroupInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BankGroupInsert
	END
END
GO

SET NOCOUNT OFF
GO    