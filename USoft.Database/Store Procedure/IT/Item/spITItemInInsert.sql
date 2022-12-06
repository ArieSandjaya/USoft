IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInInsert'
	DROP PROCEDURE [dbo].[spITItemInInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemInInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-29
**	Description		: SP untuk Insert Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInInsert
	@povchItemInCode VARCHAR(8) OUTPUT,
	@pidtmDateIn DATETIME,
	@piintBranchFrom INT,
	@pivchSupplierCode varchar(6),
	--@pivchPIC varchar(20), 
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		SELECT @povchItemInCode = dbo.fnGenItemInCode()
		
		INSERT INTO IT_ItemIn (
			ITItemInCode,
			Date,
			BranchId,
			SupplierCode,
			--PIC,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			@povchItemInCode,
			@pidtmDateIn,
			CASE 
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			CASE 
				WHEN @pivchSupplierCode = '' THEN NULL
				ELSE @pivchSupplierCode
			END,
			--@pivchPIC,
			'D',
			0,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
	
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInInsert
	END
END
GO

SET NOCOUNT OFF
GO   