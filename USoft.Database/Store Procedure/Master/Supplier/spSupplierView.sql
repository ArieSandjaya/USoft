IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spSupplierView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spSupplierView'
	DROP PROCEDURE [dbo].[spSupplierView]
END
GO

PRINT 'CREATE PROCEDURE spSupplierView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spSupplierView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-10
**	Description		: SP untuk show Supplier Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spSupplierView		
	@pivchSupplierCode VARCHAR(6)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		SupplierName,
		Address,
		City,
		ZipCode,
		Phone,
		NPWP,
		State,
		IsActive
	FROM
		MsSupplier WITH(NOLOCK)
	WHERE
		SupplierCode = @pivchSupplierCode
		
END
GO

SET NOCOUNT OFF
GO       