IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spB2BSendMail]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spB2BSendMail'
	DROP PROCEDURE [dbo].[spB2BSendMail]
END
GO

PRINT 'CREATE PROCEDURE spB2BSendMail'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spB2BSendMail / b2b_sendMail_Raksa / b2b_sendMail_Tokio / b2b_sendMail_Aswata
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show B2B Mail Raksa
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spB2BSendMail		
	@piintBranchId INT,
	@pivchInsType VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Email,
		EmailType,
		EmailSource
	FROM
		B2B_DefaultEmail WITH(NOLOCK)
	WHERE
		DeleteFlag = 'N'
		AND
		EmailSource = @pivchInsType
		
	UNION 
	
	SELECT
		Email,
		'CC' AS EmailType,
		'UFI' AS EmailSource
	FROM
		MsUSers WITH(NOLOCK)
	WHERE
		BranchId = @piintBranchId
		AND
		IsActive = 1
		AND
		CanSendMail = 'Y'
END
GO

SET NOCOUNT OFF
GO    