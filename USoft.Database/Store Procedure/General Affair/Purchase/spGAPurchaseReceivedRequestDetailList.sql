IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedRequestDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedRequestDetailList'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedRequestDetailList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedRequestDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedRequestDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Received Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedRequestDetailList		
	@pivchRequestID VARCHAR(30),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	SET @pivchWhereBy = 'a.RequestId IN (
							SELECT
								x.RequestId
							FROM
								GA_POrderDtl AS x WITH(NOLOCK)
								INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
									x.OrderId = y.OrderId
							WHERE
								y.ReceivedId = ''' + @pivchWhereBy + '''
						)
						AND
						a.RequestDetailId NOT IN (
							SELECT
								RequestDetailId
							FROM
								GA_POReceivedDtl WITH(NOLOCK)
							WHERE
								ReceivedId = ''' + @pivchWhereBy + '''
						)'
	
	EXEC spGAPurchaseRequestDetailList
		@pivchRequestID,
		@pivchWhereBy
END
GO

SET NOCOUNT OFF
GO   