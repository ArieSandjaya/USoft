 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailDelete'
	DROP PROCEDURE [dbo].[spITItemTransDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Delete data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailDelete
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemTransDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM
			IT_ItemTransDtl
		WHERE
			ITItemTransDtlCode = @pivchItemTransDetailCode
			AND ITItemTransCode = @pivchItemTransCode
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITItemTransDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemTransDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO    