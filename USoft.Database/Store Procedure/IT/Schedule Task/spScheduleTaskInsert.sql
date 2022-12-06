IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskInsert'
	DROP PROCEDURE [dbo].[spScheduleTaskInsert]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskInsert
	@pivchScheduleType VARCHAR(1),
    @pivchScheduleTitle VARCHAR(255),
    @pidtmStartDate DATETIME,
    @pidtmEndDate DATETIME,
    @pivchIntervalBy VARCHAR(1),
    @piintIntervalRange INT,
    @pivchIntervalHour VARCHAR(2),
    @pivchIntervalMinute VARCHAR(2),
    @pivchDescription VARCHAR(255),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskInsert
		DECLARE
			@ErrMsg VARCHAR(2000)

		--* Default Value
		IF CONVERT(VARCHAR(8),@pidtmStartDate,112) = '17530101'
			SET @pidtmStartDate = NULL

		IF CONVERT(VARCHAR(8),@pidtmEndDate,112) = '17530101'
			SET @pidtmEndDate = NULL

		--* Validation
		IF (@pidtmEndDate IS NOT NULL)
			AND
			(CONVERT(VARCHAR(8),@pidtmStartDate,112) > CONVERT(VARCHAR(8),@pidtmEndDate,112))
		BEGIN
			SET @ErrMsg = 'End Date (' + CONVERT(VARCHAR(10),@pidtmEndDate,105) + ') must bigger or equivalent than Start Date (' + CONVERT(VARCHAR(10),@pidtmStartDate,105) + ')'
			GOTO ExitSP	
		END
		
		IF (@piintIntervalRange < 0)
		BEGIN
			SET @ErrMsg = 'Interval must be larger than zero (0)'
			GOTO ExitSP	
		END

		IF (
			(@pivchIntervalBy = '2')
			AND
			(
				ISDATE(
					CONVERT(VARCHAR(8),@pidtmStartDate,120)
					+
					CONVERT(VARCHAR,@piintIntervalRange)
				) = 0
			)
		)
		BEGIN
			SET @ErrMsg = 'Range Date Invalid'
			GOTO ExitSP	
		END
		
		--*
		INSERT INTO IT_ScheduleTask (
			ScheduleNo,
			ScheduleType,
			ScheduleTitle,
			StartDate,
			EndDate,
			IntervalBy,
			IntervalRange,
			IntervalHour,
			IntervalMinute,
			Description,
			Status,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenScheduleNo(),
			@pivchScheduleType,
			@pivchScheduleTitle,
			@pidtmStartDate,
			@pidtmEndDate,
			@pivchIntervalBy,
			@piintIntervalRange,
			@pivchIntervalHour,
			@pivchIntervalMinute,
			@pivchDescription,
			'1',
			GETDATE(),
			@pivchInputID
		
		IF @@ERROR <> 0
			GOTO ExitSP
		
	COMMIT TRAN ScheduleTaskInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskInsert
	END
END
GO

SET NOCOUNT OFF
GO