IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailView'
	DROP PROCEDURE [dbo].[spITItemInDetailView]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk show data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailView		
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemInDtlCode,
		a.ITItemInCode,	
		a.StatusIn,		
		a.ItemTypeCode,	
		b.ItemTypeName,
		a.ITItemOutCode,
		d.SerialNo AS OldSerialNo,
		a.SerialNo,	
		a.Barcode,	
		a.Description,	
		a.ParentCode,	
		a.ConditionCode,	
		e.ConditionName
	FROM
		IT_ItemInDtl AS a WITH(NOLOCK)
		INNER JOIN IT_ItemType AS b WITH(NOLOCK) ON (a.ItemTypeCode = b.ItemTypeCode)
		LEFT JOIN IT_ItemOut AS c WITH(NOLOCK) ON (a.ITItemOutCode = c.ITItemOutCode)
		LEFT JOIN IT_Item AS d WITH(NOLOCK) ON (c.ITItemCode = d.ITItemCode)
		INNER JOIN IT_Condition AS e WITH(NOLOCK) ON (a.ConditionCode = e.ConditionCode)
	WHERE
		a.ITItemInDtlCode = @pivchItemInDetailCode
		AND a.ITItemInCode = @pivchItemInCode
END
GO

SET NOCOUNT OFF
GO    