IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemGroupView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemGroupView'
	DROP PROCEDURE [dbo].[spGAItemGroupView]
END
GO

PRINT 'CREATE PROCEDURE spGAItemGroupView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemGroupView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show GA Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemGroupView		
	@pivchItemGroupCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ItemGroupCode,
		a.ItemGroupName,
		a.ItemCategoryCode,
		b.ItemCategoryName,
		a.IsActive
	FROM
		GA_ItemGroup AS a WITH(NOLOCK) 
		INNER JOIN GA_ItemCategory AS b WITH(NOLOCK) ON
			a.ItemCategoryCode = b.ItemCategoryCode
	WHERE
		a.ItemGroupCode = @pivchItemGroupCode
END
GO

SET NOCOUNT OFF
GO       