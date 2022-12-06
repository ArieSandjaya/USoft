IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTypeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTypeView'
	DROP PROCEDURE [dbo].[spITItemTypeView]
END
GO

PRINT 'CREATE PROCEDURE spITItemTypeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTypeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-07-03
**	Description		: SP untuk view data IT Item Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTypeView		
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ItemTypeCode,
		ItemTypeName,
		IsActive
	FROM
		IT_ItemType WITH(NOLOCK)
	WHERE
		ItemTypeCode = @pivchItemTypeCode
END
GO

SET NOCOUNT OFF
GO      