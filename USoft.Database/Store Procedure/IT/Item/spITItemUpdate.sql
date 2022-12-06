IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemUpdate'
	DROP PROCEDURE [dbo].[spITItemUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk Update Data Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemUpdate
	@pivchItemCode VARCHAR(10),
	@pivchDescription VARCHAR(255),
	@piintConditionCode INT,
	@pivchInputBy VARCHAR(50)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_Item
		SET
			Description = @pivchDescription,
			ConditionCode = @piintConditionCode,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemCode = @pivchItemCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
		INSERT INTO IT_Item_History
		SELECT * FROM IT_Item
		WHERE
			ITItemCode = @pivchItemCode
		
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN ItemUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemUpdate
	END
END
GO

SET NOCOUNT OFF
GO     