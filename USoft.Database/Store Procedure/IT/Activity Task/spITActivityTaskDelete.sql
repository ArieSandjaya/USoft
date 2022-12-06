IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityTaskDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityTaskDelete'
	DROP PROCEDURE [dbo].[spITActivityTaskDelete]
END
GO

PRINT 'CREATE PROCEDURE spITActivityTaskDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityTaskDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityTaskDelete
	@pivchActivityNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityTaskDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ActivityTask
		SET
			IsActive = 0
		WHERE
			ActivityNo = @pivchActivityNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityTaskDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskDelete
	END
END
GO

SET NOCOUNT OFF
GO    