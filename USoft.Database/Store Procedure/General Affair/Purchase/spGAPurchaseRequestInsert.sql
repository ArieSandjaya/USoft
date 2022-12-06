IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestInsert'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestInsert]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk GA Insert Purchase Request Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestInsert
	@povchRequestID VARCHAR(30) OUTPUT,
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
	
	BEGIN TRAN PurchaseRequestInsert
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
			
		SELECT @povchRequestID = dbo.fnGenGAPurchaseRequestNo()
		
		INSERT INTO GA_PORequest (
			RequestId,
			RequestDate,
			Type,
			Reason,
			SupplierCode,
			CurrencyCode,
			Description,
			Status,
			ApprovalState,
			created_date,
			created_by,
			BranchId,
			DepartementCode
		)
		SELECT
			@povchRequestID,
			@pidtmRequestDate,
			@pichrType,
			@pivchReason,
			CASE
				WHEN @pivchSupplierCode = '' THEN NULL
				ELSE @pivchSupplierCode
			END,
			@pivchCurrencyCode,
			@pivchDescription,
			'D',
			0,
			GETDATE(),
			@pivchInputID,
			@BranchID,
			@DepartementCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseRequestInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseRequestInsert
	END
END
GO

SET NOCOUNT OFF
GO  