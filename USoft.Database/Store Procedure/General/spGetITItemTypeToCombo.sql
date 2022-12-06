IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-03
**	Description		: SP untuk Bind data IT Item Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemTypeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ItemTypeCode,
			ItemTypeName
		FROM
			IT_ItemType WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   