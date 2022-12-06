IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGASupplierInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGASupplierInsert'
	DROP PROCEDURE [dbo].[spGASupplierInsert]
END
GO

PRINT 'CREATE PROCEDURE spGASupplierInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGASupplierInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Insert GA Supplier Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGASupplierInsert
	@pivchSupplierCode VARCHAR(5),
	@pivchSupplierName VARCHAR(100),
	@pivchAddress VARCHAR(255),
	@pivchCity VARCHAR(20),
	@pivchZipCode VARCHAR(6),
	@pivchPhone VARCHAR(50),
	@pivchNPWP VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN SupplierInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM GA_Supplier WITH(NOLOCK) 
				WHERE SupplierCode = @pivchSupplierCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Supplier Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO GA_Supplier (
				SupplierCode,
				SupplierName,
				Address,
				City,
				ZipCode,
				Phone,
				NPWP,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchSupplierCode,
				@pivchSupplierName,
				@pivchAddress,
				@pivchCity,
				@pivchZipCode,
				@pivchPhone,
				@pivchNPWP,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
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