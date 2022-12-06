IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskList'
	DROP PROCEDURE [dbo].[spScheduleTaskList]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskList		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE
		@sql VARCHAR(8000),
		@sqlWhere VARCHAR(8000)

	IF (@pivchWhereBy <> '')
		SET @sqlWhere = ' AND ' + @pivchWhereBy
	
	-- Paging Start
	DECLARE @FirstRec int, @LastRec int
	IF @piintPageNo < 0
		SET @piintPageNo = 0
    SELECT
		@FirstRec = (@piintPageNo - 1) * @piintPageSize + 1,
		@LastRec = (@piintPageNo * @piintPageSize)
	
	CREATE TABLE #TotalRecord (
		TotalRecords INT
	)

	SET @sql = 'INSERT INTO #TotalRecord (TotalRecords)
				SELECT
					COUNT(*)
				FROM
					IT_ScheduleTask AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.created_by = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.update_by = c.UserId
				WHERE
					a.Status <> ''0''
				' + ISNULL(@sqlWhere,'')
	EXEC(@sql)

    SELECT @pointTotalData = TotalRecords from #TotalRecord

    DROP TABLE #TotalRecord

	SELECT @pointTotalPage = (@pointTotalData / @piintPageSize) + CASE WHEN @pointTotalData % @piintPageSize > 0 THEN 1 ELSE 0 END

	IF ((@piintPageNo * @piintPageSize) > @pointTotalData) -- Get Last Data
		SELECT @piintPageSize = CASE WHEN @pointTotalPage < @piintPageNo THEN 0 ELSE (@pointTotalData - ((@piintPageNo - 1) * @piintPageSize)) END
	-- Paging End

	SET @sql = 'SELECT TOP 100 PERCENT *
				FROM (	
					SELECT TOP ' + convert(varchar,@piintPageSize) + ' * 
					FROM (
						SELECT TOP ' + CONVERT(VARCHAR,@LastRec) + '
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
							c.UserName AS UserUpdate
						FROM
							IT_ScheduleTask AS a WITH(NOLOCK)
							INNER JOIN MsUsers AS b WITH(NOLOCK) ON
								a.created_by = b.UserId
							LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
								a.update_by = c.UserId
						WHERE
							a.Status <> ''0''
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ScheduleNo
							DESC
					) AS Qry1
					ORDER BY
						ScheduleNo
						ASC
				) AS Qry2
				ORDER BY
					ScheduleNo
					DESC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    