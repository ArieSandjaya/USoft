IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutList'
	DROP PROCEDURE [dbo].[spITItemOutList]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-14
**	Description		: SP untuk show data Item yang OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemOutList]		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000),
			@sqlWhere VARCHAR(8000)
	
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
					IT_ItemOut AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
					INNER JOIN MsUsers AS c WITH(NOLOCK) ON a.PIC = c.UserId
					INNER JOIN IT_Item AS d WITH(NOLOCK) ON a.ITItemCode = d.ITItemCode
					INNER JOIN IT_ItemType AS e WITH(NOLOCK) ON d.ItemTypeCode = e.ItemTypeCode
					INNER JOIN IT_Condition AS f WITH(NOLOCK) ON a.ConditionCode = f.ConditionCode
					LEFT JOIN MsSupplier AS g WITH(NOLOCK) ON a.SupplierCode = g.SupplierCode	
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
							a.ITItemOutCode,	 
							a.ITItemCode,
							d.SerialNo + '' - '' + d.Description AS ITItemName,
							d.ItemTypeCode,
							e.ItemTypeName,
							d.SerialNo,
							a.Date,	 
							a.BranchId,
							CASE 
								WHEN a.BranchId IS NULL THEN ''Warehouse''
								ELSE b.BranchName
							END AS BranchName,
							a.SupplierCode,	
							g.SupplierName, 
							a.ConditionCode, 
							f.ConditionName,
							a.StatusOut,
							a.PIC,
							c.UserName AS PICName,
							a.Status,
							CASE
								WHEN a.RepairStatus = 1 THEN ''In Progress''
								WHEN a.RepairStatus = 2 THEN ''Done''
								ELSE ''-''
							END AS RepairStatus,
							a.Remark,
							a.ApprovalState,
							a.created_by AS CreatedName
						FROM
							IT_ItemOut AS a WITH(NOLOCK)
							LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
							INNER JOIN MsUsers AS c WITH(NOLOCK) ON a.PIC = c.UserId
							INNER JOIN IT_Item AS d WITH(NOLOCK) ON a.ITItemCode = d.ITItemCode
							INNER JOIN IT_ItemType AS e WITH(NOLOCK) ON d.ItemTypeCode = e.ItemTypeCode
							INNER JOIN IT_Condition AS f WITH(NOLOCK) ON a.ConditionCode = f.ConditionCode
							LEFT JOIN MsSupplier AS g WITH(NOLOCK) ON a.SupplierCode = g.SupplierCode	
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ITItemOutCode
							ASC
					) AS Qry1
					ORDER BY
						ITItemOutCode
						DESC
				) AS Qry2
				ORDER BY
					ITItemOutCode
					ASC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  