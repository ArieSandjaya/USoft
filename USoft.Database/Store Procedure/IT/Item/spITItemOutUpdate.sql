IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdate'
	DROP PROCEDURE [dbo].[spITItemOutUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Update Data Item-OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdate
	@pivchItemOutCode VARCHAR(8),
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
	
	BEGIN TRAN ItemOutUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT '' FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @pivchItemCode AND ITItemOutCode IS NOT NULL
			)
		)
		BEGIN
			SET @ErrMsg = 'Item with code ' + @pivchItemCode + ' is under Repair or already Dispose.'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemOut
		SET
			Date = @pidtmDateOut,
			ITItemCode = @pivchItemCode,
			BranchId = CASE 
							WHEN @piintBranchFrom = 0 THEN NULL
							ELSE @piintBranchFrom
						END,
			StatusOut = @piintStatusOut,
			ConditionCode = @piintConditionCode,
			SupplierCode =  CASE
								WHEN @pivchSupplierCode = '' THEN NULL
								ELSE @pivchSupplierCode
							END,
			PIC = @pivchPIC,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemOutCode = @pivchItemOutCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemOutUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END	
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdate
	END
END
GO

SET NOCOUNT OFF
GO     