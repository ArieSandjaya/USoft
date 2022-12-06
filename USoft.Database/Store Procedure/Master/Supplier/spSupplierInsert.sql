IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spSupplierInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spSupplierInsert'
	DROP PROCEDURE [dbo].[spSupplierInsert]
END
GO

PRINT 'CREATE PROCEDURE spSupplierInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spSupplierInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-10
**	Description		: SP untuk Insert Master Supplier Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spSupplierInsert
	@povchSupplierCode VARCHAR(6) OUTPUT,
	@pivchSupplierName VARCHAR(100),
	@pivchAddress VARCHAR(255),
	@pivchCity VARCHAR(20),
	@pivchZipCode VARCHAR(6),
	@pivchPhone VARCHAR(50),
	@pivchNPWP VARCHAR(20),
	@pivchState VARCHAR(6),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN SupplierInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
		
		SELECT @povchSupplierCode = dbo.fnGenSupplierCode(@pivchState)
		
		INSERT INTO MsSupplier (
			SupplierCode,
			SupplierName,
			Address,
			City,
			ZipCode,
			Phone,
			NPWP,
			State,
			IsActive,
			created_date,
			created_by
		)
		SELECT
			@povchSupplierCode,
			@pivchSupplierName,
			@pivchAddress,
			@pivchCity,
			@pivchZipCode,
			@pivchPhone,
			@pivchNPWP,
			@pivchState,
			@pibitIsActive,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
		
	COMMIT TRAN SupplierInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN SupplierInsert
	END
END
GO

SET NOCOUNT OFF
GO      