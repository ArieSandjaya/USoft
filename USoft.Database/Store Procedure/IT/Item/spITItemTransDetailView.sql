IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailView'
	DROP PROCEDURE [dbo].[spITItemTransDetailView]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk show data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailView		
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemTransDtlCode,
		a.ITItemTransCode,
		a.ITItemCode,
		a.ConditionCode,
		a.UsedBy,
		a.PrivilegeCode,
		b.ItemTypeCode
	FROM
		IT_ItemTransDtl AS a WITH(NOLOCK)
		INNER JOIN IT_Item AS b WITH(NOLOCK) ON
			a.ITItemCode = b.ITItemCode
	WHERE
		a.ITItemTransDtlCode = @pivchItemTransDetailCode
		AND a.ITItemTransCode = @pivchItemTransCode
END
GO

SET NOCOUNT OFF
GO    