IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spSupplierUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spSupplierUpdate'
	DROP PROCEDURE [dbo].[spSupplierUpdate]
END
GO

PRINT 'CREATE PROCEDURE spSupplierUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spSupplierUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-10
**	Description		: SP untuk Update Supplier Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spSupplierUpdate
	@pivchSupplierCode VARCHAR(6),
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
	
	BEGIN TRAN SupplierUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsSupplier
		SET
			SupplierName = @pivchSupplierName,
			Address = @pivchAddress,
			City = @pivchCity,
			ZipCode = @pivchZipCode,
			Phone = @pivchPhone,
			NPWP = @pivchNPWP,
			State = @pivchState,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			SupplierCode = @pivchSupplierCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN SupplierUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN SupplierUpdate
	END
END
GO

SET NOCOUNT OFF
GO       