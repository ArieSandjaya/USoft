 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInView'
	DROP PROCEDURE [dbo].[spITItemInView]
END
GO

PRINT 'CREATE PROCEDURE spITItemInView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-29
**	Description		: SP untuk show detail data Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInView		
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemInCode,
		a.Date,
		ReceiveType = CASE
						WHEN a.BranchId IS NOT NULL THEN '1'   --Branch
						WHEN a.SupplierCode IS NOT NULL THEN '2' --Vendor
					END,
		a.BranchId,
		d.BranchName as BranchNameFrom,	
		a.SupplierCode,
		e.SupplierName,
		--a.PIC,
		a.Status,
		a.created_by AS CreatedBy,
		c.UserName AS CreatedName,
		a.ApprovalState
	FROM
		IT_ItemIn AS a WITH(NOLOCK) 
		--INNER JOIN MsUsers AS b ON a.PIC = b.UserId
		LEFT JOIN MsUsers AS c ON a.created_by = c.UserId
		LEFT JOIN MsBranch AS d ON a.BranchId = d.BranchId
		LEFT JOIN MsSupplier AS e ON a.SupplierCode = e.SupplierCode
	WHERE
		a.ITItemInCode = @pivchItemInCode
END
GO

SET NOCOUNT OFF
GO  