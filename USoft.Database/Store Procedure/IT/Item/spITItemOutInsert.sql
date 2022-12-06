 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutInsert'
	DROP PROCEDURE [dbo].[spITItemOutInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Insert Item-OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutInsert
	@pidtmDateOut DATETIME,
	@piintBranchFrom INT,
	@pivchItemCode VARCHAR(10),
	@piintConditionCode INT,
	@piintStatusOut INT,
	@pivchSupplierCode VARCHAR(50),
	@pivchPIC varchar(50),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@NewItemOutCode VARCHAR(8)
				
		IF(  
			EXISTS(
				SELECT '' FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @pivchItemCode AND ITItemOutCode IS NOT NULL 
			)
		)
		BEGIN
			SET @ErrMsg = 'Item with code ' + @pivchItemCode + ' is under Repair or already Dispose.'
			GOTO ExitSP
		END
		
		
		SET @NewItemOutCode = dbo.fnGenItemOutCode()
		
		INSERT INTO IT_ItemOut (
			ITItemOutCode,
			ITItemCode,
			Date,
			BranchId,
			StatusOut,
			ConditionCode,
			SupplierCode,
			PIC,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			@NewItemOutCode,
			@pivchItemCode,
			@pidtmDateOut,
			CASE
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			@piintStatusOut,
			@piintConditionCode,
			CASE
				WHEN @pivchSupplierCode = '' THEN NULL
				ELSE @pivchSupplierCode
			END,
			@pivchPIC,
			'D', --- status DRAFT
			0,   --ApprovalState 0
			GETDATE(),
			@pivchInputBy
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemOutInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutInsert
	END
END
GO

SET NOCOUNT OFF
GO   