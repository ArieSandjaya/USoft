IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderDetailList'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderDetailList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Order Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderDetailList		
	@pivchOrderID VARCHAR(30),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					ROW_NUMBER() OVER(ORDER BY OrderDetailId ASC) AS ''No'',
					a.*,
					b.RequestDate,					
					ISNULL(b.Total,0) AS Total,
					c.BranchName,
					d.UserName
				FROM
					GA_POrderDtl AS a WITH(NOLOCK)
					INNER JOIN GA_PORequest AS b WITH(NOLOCK) ON (a.RequestId = b.RequestId)
					INNER JOIN MsBranch AS c WITH(NOLOCK) ON (b.BranchId = c.BranchId)
					INNER JOIN MsUsers AS d WITH(NOLOCK) ON (b.created_by = d.UserId)
				WHERE
					a.OrderId = ''' + @pivchOrderID + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  