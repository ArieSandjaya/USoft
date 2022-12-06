 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemHistory]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemHistory'
	DROP PROCEDURE [dbo].[spITItemHistory]
END
GO

PRINT 'CREATE PROCEDURE spITItemHistory'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemHistory
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show data Item Detail History
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemHistory		
	@pivchItemCode VARCHAR(10),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000),
			@sqlWhere VARCHAR(8000)
			
	--SET @sqlWhere = ' AND ' + @pivchItemCode
	
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
					IT_Item_History AS a WITH(NOLOCK)
					INNER JOIN IT_ItemType AS b WITH(NOLOCK) ON (a.ItemTypeCode = b.ItemTypeCode)
					INNER JOIN IT_Condition AS c WITH(NOLOCK) ON (a.ConditionCode = c.ConditionCode)
					LEFT JOIN MsBranch d WITH(NOLOCK)  ON a.BranchId = d.BranchId
					LEFT JOIN MsPrivilege e WITH(NOLOCK)  ON a.PrivilegeCode = e.PrivilegeCode
				WHERE
					a.ITItemCode = ''' + @pivchItemCode + '''
				' -- + ISNULL(@sqlWhere,'')
				
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
							a.ITItemCode,
							a.ITItemInDtlCode,
							b.ItemTypeName,
							a.SerialNo,
							a.Barcode,
							c.ConditionName,
							a.BranchId,
							ISNULL(d.BranchName, CASE WHEN a.StatusOut IS NOT NULL THEN ''-'' 
													  ELSE ''Warehouse''
												 END ) 
							AS BranchName,
							ISNULL(a.UsedBy,''-'') AS UsedBy,
							e.PrivilegeName,
							a.Remark,
							a.created_date
							
						FROM
							IT_Item_History AS a WITH(NOLOCK)
							INNER JOIN IT_ItemType AS b WITH(NOLOCK) ON (a.ItemTypeCode = b.ItemTypeCode)
							INNER JOIN IT_Condition AS c WITH(NOLOCK) ON (a.ConditionCode = c.ConditionCode)
							LEFT JOIN MsBranch d WITH(NOLOCK)  ON a.BranchId = d.BranchId
							LEFT JOIN MsPrivilege e WITH(NOLOCK)  ON a.PrivilegeCode = e.PrivilegeCode
						WHERE
							a.ITItemCode = ''' + @pivchItemCode + '''		
						
						ORDER BY 
							a.created_date
							DESC
					) AS Qry1
					ORDER BY
						created_date
						ASC
				) AS Qry2
				ORDER BY
					created_date
					DESC'
			
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   


