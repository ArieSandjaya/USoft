IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetGAPurchaseOrderToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetGAPurchaseOrderToCombo'
	DROP PROCEDURE [dbo].[spGetGAPurchaseOrderToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetGAPurchaseOrderToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetGAPurchaseOrderToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data GA Purchase Order
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetGAPurchaseOrderToCombo
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			OrderId
		FROM
			GA_POrder WITH(NOLOCK)
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   