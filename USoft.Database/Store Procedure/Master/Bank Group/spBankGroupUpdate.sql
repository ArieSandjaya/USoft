IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBankGroupUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBankGroupUpdate'
	DROP PROCEDURE [dbo].[spBankGroupUpdate]
END
GO

PRINT 'CREATE PROCEDURE spBankGroupUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBankGroupUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Bank Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBankGroupUpdate
	@pivchBankGroupCode VARCHAR(3),
	@pivchBankGroupName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BankGroupUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsBankGroup
		SET
			BankGroupName = @pivchBankGroupName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			BankGroupCode = @pivchBankGroupCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN BankGroupUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BankGroupUpdate
	END
END
GO

SET NOCOUNT OFF
GO    