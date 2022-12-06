IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGASupplierView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGASupplierView'
	DROP PROCEDURE [dbo].[spGASupplierView]
END
GO

PRINT 'CREATE PROCEDURE spGASupplierView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGASupplierView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show GA Supplier Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGASupplierView		
	@pivchSupplierCode VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		SupplierCode,
		SupplierName,
		Address,
		City,
		ZipCode,
		Phone,
		NPWP,
		IsActive
	FROM
		GA_Supplier WITH(NOLOCK)
	WHERE
		SupplierCode = @pivchSupplierCode
END
GO

SET NOCOUNT OFF
GO      