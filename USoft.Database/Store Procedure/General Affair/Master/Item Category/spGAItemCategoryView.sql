 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAItemCategoryView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAItemCategoryView'
	DROP PROCEDURE [dbo].[spGAItemCategoryView]
END
GO

PRINT 'CREATE PROCEDURE spGAItemCategoryView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAItemCategoryView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show GA Item Category Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAItemCategoryView		
	@pivchItemCategoryCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ItemCategoryCode,
		ItemCategoryName,
		IsActive
	FROM
		GA_ItemCategory WITH(NOLOCK)
	WHERE
		ItemCategoryCode = @pivchItemCategoryCode
END
GO

SET NOCOUNT OFF
GO      