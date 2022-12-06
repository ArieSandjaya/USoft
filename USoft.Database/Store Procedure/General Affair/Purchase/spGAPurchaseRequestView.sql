IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestView'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestView]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Request Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestView		
	@pivchRequestID VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.RequestId,
		a.RequestDate,
		a.Type,
		a.Reason,
		a.SupplierCode,
		f.SupplierName,
		ISNULL(a.total,0) AS total,
		a.CurrencyCode,
		a.BranchId,
		c.BranchName,
		a.DepartementCode,
		e.DepartementName,
		a.Description,
		a.Status,
		ISNULL(a.ApprovalState,0) AS ApprovalState,
		a.created_by AS CreatedBy,
		b.UserName AS CreatedName,
		a.update_by AS UpdateBy,
		g.UserName AS UpdateName
	FROM
		GA_PORequest AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
		INNER JOIN MsBranch AS c WITH(NOLOCK) ON b.BranchId = c.BranchId
		INNER JOIN MsPrivilege AS d WITH(NOLOCK) ON b.PrivilegeCode = d.PrivilegeCode
		INNER JOIN MsDepartement AS e WITH(NOLOCK) ON d.DepartementCode = e.DepartementCode
		LEFT JOIN GA_Supplier AS f WITH(NOLOCK) ON a.SupplierCode = f.SupplierCode
		LEFT JOIN MsUsers AS g WITH(NOLOCK) ON a.update_by = g.UserId
	WHERE
		a.RequestId = @pivchRequestID
END
GO

SET NOCOUNT OFF
GO  