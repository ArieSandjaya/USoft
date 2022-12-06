  IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemView'
	DROP PROCEDURE [dbo].[spITItemView]
END
GO

PRINT 'CREATE PROCEDURE spITItemView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk show data Detail Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemView		
	@pivchItemCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		A.ITItemCode,
		A.ITItemInDtlCode,
		A.ITItemTransDtlCode,
		A.ITItemOutCode,
		B.ItemTypeCode,
		B.ItemTypeName,
		A.SerialNo,
		A.Barcode,
		A.Description,
		C.ConditionCode,
		C.ConditionName,
		A.StatusIn,
		A.StatusOut,
		D.BranchId,
		ISNULL(D.BranchName,'Warehouse') AS BranchName,
		A.UsedBy,
		E.PrivilegeCode,
		E.PrivilegeName,
		A.IsActive
	FROM
		IT_Item as A WITH(NOLOCK)
		INNER JOIN IT_ItemType as B WITH(NOLOCK) ON A.ItemTypeCode = B.ItemTypeCode	
		INNER JOIN IT_Condition C WITH(NOLOCK)  ON A.ConditionCode = C.ConditionCode
		LEFT JOIN MsBranch as D WITH(NOLOCK)  ON A.BranchId = D.BranchId
		LEFT JOIN MsPrivilege as E WITH(NOLOCK)  ON A.PrivilegeCode = E.PrivilegeCode
	WHERE
		A.ITItemCode = @pivchItemCode
END
GO

SET NOCOUNT OFF
GO  