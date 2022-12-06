IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInUpdate'
	DROP PROCEDURE [dbo].[spITItemInUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemInUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Data Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInUpdate
	@pivchItemInCode VARCHAR(8),
	@pidtmDateIn DATETIME,
	@piintBranchFrom INT,
	@pivchSupplierCode VARCHAR(100),
	--@pivchPIC VARCHAR(20),
	@pivchInputID VARCHAR(50)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_ItemIn
		SET
			Date = @pidtmDateIn,
			BranchId =  CASE 
							WHEN @piintBranchFrom = 0 THEN NULL
							ELSE @piintBranchFrom
						END,
			SupplierCode = CASE 
							WHEN @pivchSupplierCode = '' THEN NULL
							ELSE @pivchSupplierCode
						 END,
			--PIC = @pivchPIC,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ITItemInCode = @pivchItemInCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInUpdate
	END
END
GO

SET NOCOUNT OFF
GO    