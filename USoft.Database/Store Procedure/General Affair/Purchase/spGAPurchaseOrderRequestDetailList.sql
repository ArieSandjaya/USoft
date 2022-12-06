IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderRequestDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderRequestDetailList'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderRequestDetailList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderRequestDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderRequestDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Order Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderRequestDetailList		
	@pivchRequestID VARCHAR(30),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	SET @pivchWhereBy = 'a.RequestId IN (
							SELECT
								RequestId
							FROM
								GA_POrderDtl WITH(NOLOCK)
							WHERE
								OrderId = ''' + @pivchWhereBy + '''
						)'
	
	EXEC spGAPurchaseRequestDetailList
		@pivchRequestID,
		@pivchWhereBy
END
GO

SET NOCOUNT OFF
GO  