IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemTypeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemTypeView'
	DROP PROCEDURE [dbo].[spGAItemTypeView]
END
GO

PRINT 'CREATE PROCEDURE spGAItemTypeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemTypeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show GA Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemTypeView		
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ItemTypeCode,
		a.ItemTypeName,
		a.ItemGroupCode,
		b.ItemGroupName,
		b.ItemCategoryCode,
		c.ItemCategoryName,
		a.MeasurementCode,
		a.Description,
		a.IsActive
	FROM
		GA_ItemType AS a WITH(NOLOCK) 
		INNER JOIN GA_ItemGroup AS b WITH(NOLOCK) ON
			a.ItemGroupCode = b.ItemGroupCode
		INNER JOIN GA_ItemCategory AS c WITH(NOLOCK) ON
			b.ItemCategoryCode = c.ItemCategoryCode
	WHERE
		a.ItemTypeCode = @pivchItemTypeCode
END
GO

SET NOCOUNT OFF
GO       