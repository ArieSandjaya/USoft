IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskFinish]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskFinish'
	DROP PROCEDURE [dbo].[spScheduleTaskFinish]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskFinish'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskFinish
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Finish Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskFinish
	@pivchScheduleNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskFinish
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ScheduleTask
		SET
			Status = '2'
		WHERE
			ScheduleNo = @pivchScheduleNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ScheduleTaskFinish
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskFinish
	END
END
GO

SET NOCOUNT OFF
GO      