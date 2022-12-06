IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailList'
	DROP PROCEDURE [dbo].[spITItemTransDetailList]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk show data Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailList
	@pivchItemTransCode VARCHAR(8),		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.*,
					b.SerialNo,
					b.Barcode,
					b.Description,
					b.ParentCode,
					c.ItemTypeName,
					d.ConditionName,
					e.PrivilegeName
				FROM
					IT_ItemTransDtl AS a WITH(NOLOCK)
					INNER JOIN IT_Item AS b WITH(NOLOCK) ON (a.ITItemCode = b.ITItemCode)
					INNER JOIN IT_ItemType AS c WITH(NOLOCK) ON (b.ItemTypeCode = c.ItemTypeCode)
					LEFT JOIN IT_Condition AS d WITH(NOLOCK) ON (a.ConditionCode = d.ConditionCode)
					LEFT JOIN MsPrivilege AS e WITH(NOLOCK) ON (a.PrivilegeCode = e.PrivilegeCode)
				WHERE
					a.ITItemTransCode = ''' + @pivchItemTransCode + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    