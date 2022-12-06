IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskDelete'
	DROP PROCEDURE [dbo].[spScheduleTaskDelete]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskDelete
	@pivchScheduleNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ScheduleTask
		SET
			Status = '0'
		WHERE
			ScheduleNo = @pivchScheduleNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ScheduleTaskDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskDelete
	END
END
GO

SET NOCOUNT OFF
GO     