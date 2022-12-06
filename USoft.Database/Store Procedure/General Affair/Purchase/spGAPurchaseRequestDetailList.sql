IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestDetailList'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestDetailList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Request Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestDetailList		
	@pivchRequestID VARCHAR(30),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					ROW_NUMBER() OVER(ORDER BY a.RequestDetailId ASC) AS ''No'',
					a.*,
					c.ItemGroupCode,
					c.ItemGroupName,
					b.ItemTypeName,
					a.Quantity * a.Price AS Total,
					(
						SELECT
							ISNULL(SUM(x.Quantity),0)
						FROM
							GA_POReceivedDtl AS x WITH(NOLOCK)
							INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
								x.ReceivedId = y.ReceivedId
						WHERE
							y.Status = ''A''
							AND x.RequestDetailId = a.RequestDetailId
					) AS QtyOutstanding,
					b.MeasurementCode
				FROM
					GA_PORequestDtl AS a WITH(NOLOCK)
					INNER JOIN GA_ItemType AS b WITH(NOLOCK) ON (a.ItemTypeCode = b.ItemTypeCode)
					INNER JOIN GA_ItemGroup AS c WITH(NOLOCK) ON (b.ItemGroupCode = c.ItemGroupCode)
				WHERE
					a.RequestId LIKE ''' + @pivchRequestID + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 