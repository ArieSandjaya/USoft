IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskView'
	DROP PROCEDURE [dbo].[spScheduleTaskView]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskView		
	@pivchScheduleNo VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ScheduleNo,
		a.ScheduleType,
		a.ScheduleTitle,
		a.Description,
		a.StartDate,
		a.EndDate,
		a.IntervalBy,
		a.IntervalRange,
		a.IntervalHour,
		a.IntervalMinute,
		a.Status,
		a.created_date,
		a.created_by,
		b.UserName AS UserCreated,
		a.update_date,
		a.update_by,
		c.UserName AS UserUpdate
	FROM
		IT_ScheduleTask AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.created_by = b.UserId
		LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
			a.update_by = c.UserId
	WHERE
		a.ScheduleNo = @pivchScheduleNo
END
GO

SET NOCOUNT OFF
GO     