IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainView'
	DROP PROCEDURE [dbo].[spBranchDomainView]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Branch Domain Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainView]		
	@pivchBranchCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Branch_Code,
		Branch_Name,
		Branch_IP,
		UserName,
		Password
	FROM
		IT_DomainServer WITH(NOLOCK)
	WHERE
		Branch_Code = @pivchBranchCode
END

SET NOCOUNT OFF
GO   