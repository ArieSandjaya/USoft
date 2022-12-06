IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskNextList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskNextList'
	DROP PROCEDURE [dbo].[spScheduleTaskNextList]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskNextList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskNextList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Next Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskNextList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000)

	SET @sql = 'DECLARE
					@MinID INT,
					@MaxID INT

				DECLARE @tmpSchedule AS TABLE (
					ID INT IDENTITY,
					ScheduleNo VARCHAR(8),
					StartDate DATETIME,
					EndDate DATETIME,
					IntervalBy VARCHAR(1),
					IntervalRange INT,
					IntervalHour VARCHAR(2),
					IntervalMinute VARCHAR(2),
					NextDate DATETIME
				)

				--*
				INSERT INTO @tmpSchedule (
					ScheduleNo,
					StartDate,
					EndDate,
					IntervalBy,
					IntervalRange,
					IntervalHour,
					IntervalMinute
				)
				SELECT
					ScheduleNo,
					StartDate,
					EndDate,
					IntervalBy,
					IntervalRange,
					IntervalHour,
					IntervalMinute
				FROM
					IT_ScheduleTask WITH(NOLOCK)
				WHERE
					Status = ''1''
					AND (
						(EndDate IS NULL)
						OR
						(CONVERT(VARCHAR(8),EndDate,112) >= CONVERT(VARCHAR(8),GETDATE(),112))
					)
				
				--*
				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpSchedule

				--*
				DECLARE
					@StartDate DATETIME,
					@EndDate DATETIME,
					@IntervalBy VARCHAR(1),
					@IntervalRange INT,
					@IntervalHour VARCHAR(2),
					@IntervalMinute VARCHAR(2),
					@NextDate DATETIME,
					@DiffDate INT,
					@TmpDate DATETIME
		
				WHILE (@MinID <= @MaxID)
				BEGIN
					SELECT
						@StartDate = StartDate,
						@EndDate = EndDate,
						@IntervalBy = IntervalBy,
						@IntervalRange = IntervalRange,
						@IntervalHour = IntervalHour,
						@IntervalMinute = IntervalMinute,
						@NextDate = NULL,
						@DiffDate = NULL
					FROM
						@tmpSchedule
					WHERE
						ID = @MinID

					SET @DiffDate = DATEDIFF(DAY,@StartDate,GETDATE())

					IF @IntervalBy = ''1''	-- Day
					BEGIN
						IF @DiffDate < 0
						BEGIN
							SET @NextDate = @StartDate
						END
						ELSE IF (@DiffDate % @IntervalRange) = 0
						BEGIN
							SET @NextDate = GETDATE()
						END
						ELSE
						BEGIN
							SET @NextDate = DATEADD(DAY, @IntervalRange - (@DiffDate % @IntervalRange), GETDATE())
						END

						SET @NextDate = CONVERT(DATETIME, CONVERT(VARCHAR(10), @NextDate, 120) + '' '' + @IntervalHour + '':'' + @IntervalMinute)
					END
					ELSE IF @IntervalBy = ''2''	-- Date
					BEGIN
						IF @DiffDate < 0
						BEGIN
							SET @TmpDate = @StartDate
						END
						ELSE
						BEGIN
							IF (DATEPART(DAY,GETDATE()) > @IntervalRange)
							BEGIN
								SET @TmpDate = CONVERT(VARCHAR(7), DATEADD(MONTH,1,GETDATE()), 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange)
							END
							ELSE
							BEGIN
								SET @TmpDate = CONVERT(VARCHAR(7), GETDATE(), 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange)
							END
						END
						
						SET @NextDate = CONVERT(DATETIME, CONVERT(VARCHAR(7), @TmpDate, 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange) + '' '' + @IntervalHour + '':'' + @IntervalMinute)
					END

					UPDATE
						@tmpSchedule
					SET
						NextDate = @NextDate
					WHERE
						ID = @MinID

					SET @MinID = @MinID + 1
				END
				
				--*
				DELETE FROM @tmpSchedule
				WHERE
					EndDate IS NOT NULL
					AND	NextDate > EndDate
				
				--*
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
					a.IntervalHour + '':'' + a.IntervalMinute AS IntervalTime,
					a.Status,
					a.created_date,
					a.created_by,
					b.UserName AS UserCreated,
					a.update_date,
					a.update_by,
					c.UserName AS UserUpdate,
					CONVERT(VARCHAR,d.NextDate,105) + '' '' + CONVERT(VARCHAR(5),d.NextDate,114) AS NextDate
				FROM
					IT_ScheduleTask AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.created_by = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.update_by = c.UserId
					INNER JOIN @tmpSchedule AS d ON
						a.ScheduleNo = d.ScheduleNo
				WHERE
					a.Status = ''1'''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY d.NextDate ASC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO     