IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailList'
	DROP PROCEDURE [dbo].[spITItemInDetailList]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-30
**	Description		: SP untuk show data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailList		
	@pivchItemInCode VARCHAR(8),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ITItemInDtlCode,
					a.ITItemInCode,	
					CASE a.StatusIn
						WHEN 1 THEN ''NEW''
						WHEN 2 THEN ''RETURN''
						WHEN 3 THEN ''REPLACE''
					END AS StatusIn,		
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
					a.ITItemInCode = ''' + @pivchItemInCode + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   