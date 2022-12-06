 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutView'
	DROP PROCEDURE [dbo].[spITItemOutView]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-14
**	Description		: SP untuk show detail data Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutView		
	@pivchItemOutCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemOutCode,	 
		a.ITItemCode,
		b.SerialNo + ' - ' + b.Description AS ITItemName,
		b.ItemTypeCode,
		d.ItemTypeName,
		a.Date,	 
		a.BranchId,
		c.BranchName,
		a.SupplierCode,
		g.SupplierName,
		a.ConditionCode,
		f.ConditionName,	 	 
		a.StatusOut,
		a.PIC,
		e.UserName AS PICName,
		a.Status,
		CASE 
			WHEN a.RepairStatus = '1' THEN 'In Progress'
			WHEN a.RepairStatus = '2' THEN 'Done'
		END AS RepairStatus,
		a.Remark,
		a.ApprovalState,
		a.created_by AS CreatedBy
	FROM
		IT_ItemOut AS a WITH(NOLOCK)
		INNER JOIN IT_Item AS b WITH(NOLOCK) ON
			a.ITItemCode = b.ITItemCode
		LEFT JOIN MsBranch AS c ON
			a.BranchId = c.BranchId
		INNER JOIN IT_ItemType AS d WITH(NOLOCK) ON
			b.ItemTypeCode = d.ItemTypeCode
		INNER JOIN MsUsers AS e WITH(NOLOCK) ON
			a.PIC = e.UserId
		INNER JOIN IT_Condition AS f WITH(NOLOCK) ON
			a.ConditionCode = f.ConditionCode
		LEFT JOIN MsSupplier AS g WITH(NOLOCK) ON 
			a.SupplierCode = g.SupplierCode
	WHERE
		a.ITItemOutCode = @pivchItemOutCode
END
GO

SET NOCOUNT OFF
GO   