IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITConditionList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITConditionList'
	DROP PROCEDURE [dbo].[spITConditionList]
END
GO

PRINT 'CREATE PROCEDURE spITConditionList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITConditionList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Condition
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITConditionList		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE
		@sql VARCHAR(2000),
		@sqlWhere VARCHAR(2000)
		
	IF (@pivchWhereBy <> '')
		SET @sqlWhere = ' WHERE ' + @pivchWhereBy	
		
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
					IT_Condition WITH(NOLOCK)
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
							ConditionCode,
							ConditionName,
							IsActive
						FROM
							IT_Condition WITH(NOLOCK)
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							ConditionCode
							ASC
					) AS Qry1
					ORDER BY
						ConditionCode
						DESC
				) AS Qry2
				ORDER BY
					ConditionCode
					ASC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   