 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailDelete'
	DROP PROCEDURE [dbo].[spITItemInDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Delete data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailDelete
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemInDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM
			IT_ItemInDtl
		WHERE
			ITItemInDtlCode = @pivchItemInDetailCode
			AND ITItemInCode = @pivchItemInCode
		
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITItemInDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemInDetailDelete
	END
	
END
GO

SET NOCOUNT OFF
GO   