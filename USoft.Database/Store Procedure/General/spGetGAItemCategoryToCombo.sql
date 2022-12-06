IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetGAItemCategoryToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetGAItemCategoryToCombo'
	DROP PROCEDURE [dbo].[spGetGAItemCategoryToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetGAItemCategoryToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetGAItemCategoryToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data GA Item Category
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetGAItemCategoryToCombo
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ItemCategoryCode,
			ItemCategoryName
		FROM
			GA_ItemCategory WITH(NOLOCK)
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