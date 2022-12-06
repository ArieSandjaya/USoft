IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITSupplierToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITSupplierToCombo'
	DROP PROCEDURE [dbo].[spGetITSupplierToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITSupplierToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITSupplierToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-10
**	Description		: SP untuk Bind Data IT Supplier To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITSupplierToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			SupplierCode,
			SupplierName
		FROM
			MsSupplier WITH(NOLOCK)
		WHERE 
			State = ''IT''
		'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      