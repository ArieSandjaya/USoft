IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyView'
	DROP PROCEDURE [dbo].[spCurrencyView]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyView		
	@pivchCurrencyCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		CurrencyCode,
		CurrencyName,
		IsActive
	FROM
		MsCurrency WITH(NOLOCK)
	WHERE
		CurrencyCode = @pivchCurrencyCode
END
GO

SET NOCOUNT OFF
GO      