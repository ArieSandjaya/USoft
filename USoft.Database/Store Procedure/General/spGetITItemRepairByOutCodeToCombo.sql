IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemRepairByOutCodeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemRepairByOutCodeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemRepairByOutCodeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemRepairByOutCodeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemRepairByOutCodeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-15
**	Description		: SP untuk Bind data IT Item SerialNo where status out Repair To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemRepairByOutCodeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			a.ITItemOutCode,
			c.ItemTypeName,
			b.SerialNo + '' / '' + b.Barcode + '' / '' + b.Description AS ItemSerialNo    
		FROM
			IT_ItemOut AS a WITH(NOLOCK)
			INNER JOIN IT_Item AS b WITH(NOLOCK) ON (a.ITItemCode = b.ITItemCode)
			INNER JOIN IT_ItemType AS c WITH(NOLOCK) ON  (b.ItemTypeCode = c.ItemTypeCode)
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

