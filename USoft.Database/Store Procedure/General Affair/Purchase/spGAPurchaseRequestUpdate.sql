IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestUpdate'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestUpdate]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk GA Update Purchase Request Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestUpdate
	@pivchRequestID VARCHAR(30),
	@pidtmRequestDate DATETIME,
	@pichrType CHAR,
	@pivchReason TEXT,
	@pivchSupplierCode VARCHAR(5),
	@pivchCurrencyCode VARCHAR(3),
	@pivchDescription VARCHAR(255),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseRequestUpdate
		DECLARE
			@BranchID INT,
			@DepartementCode VARCHAR(2),
			@ErrMsg VARCHAR(2000)
				
		SELECT
			@BranchID = a.BranchID,
			@DepartementCode = b.DepartementCode
		FROM
			MsUsers AS a WITH(NOLOCK)
			INNER JOIN MsPrivilege AS b WITH(NOLOCK) ON
				a.PrivilegeCode = b.PrivilegeCode
		WHERE
			a.UserId = @pivchInputID
			
		IF(@@ROWCOUNT = 0)
		BEGIN
			SET @ErrMsg = 'User request must be registered to Branch and Department'
			GOTO ExitSP
		END
		
		UPDATE GA_PORequest
		SET
			RequestDate = @pidtmRequestDate,
			Type = @pichrType,
			Reason = @pivchReason,
			SupplierCode = CASE
							WHEN @pivchSupplierCode = '' THEN NULL
							ELSE @pivchSupplierCode
						END,
			CurrencyCode = @pivchCurrencyCode,
			Description = @pivchDescription,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			RequestId = @pivchRequestID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseRequestUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF (@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseRequestUpdate
	END
END
GO

SET NOCOUNT OFF
GO   