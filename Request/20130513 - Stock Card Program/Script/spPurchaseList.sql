IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseList'
	DROP PROCEDURE [dbo].[spPurchaseList]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Purchase Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseList		
	@pivchOrderID VARCHAR(20),
	@pichrStatus CHAR
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		order_id,
		order_date,
		status
	FROM
		GA_PORequest
	WHERE
		order_id LIKE ISNULL(dbo.emptyToNull(@pivchOrderID),'%')
		AND status LIKE ISNULL(dbo.emptyToNull(@pichrStatus),'%')
END
GO

SET NOCOUNT OFF
GO