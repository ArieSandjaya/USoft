IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBankGroupView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBankGroupView'
	DROP PROCEDURE [dbo].[spBankGroupView]
END
GO

PRINT 'CREATE PROCEDURE spBankGroupView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBankGroupView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show BankGroup Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBankGroupView		
	@pivchBankGroupCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		BankGroupCode,
		BankGroupName,
		IsActive
	FROM
		MsBankGroup WITH(NOLOCK)
	WHERE
		BankGroupCode = @pivchBankGroupCode
END
GO

SET NOCOUNT OFF
GO    