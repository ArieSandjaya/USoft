IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInList'
	DROP PROCEDURE [dbo].[spITItemInList]
END
GO

PRINT 'CREATE PROCEDURE spITItemInList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-28
**	Description		: SP untuk show data Item yang masuk
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemInList]		
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
					IT_ItemIn AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON a.created_by = c.UserId
					LEFT JOIN MsSupplier AS d WITH(NOLOCK) ON a.SupplierCode = d.SupplierCode
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
							a.ITItemInCode,
							a.Date,
							CASE
								WHEN a.BranchId IS NOT NULL THEN ''Branch''     
								WHEN a.SupplierCode IS NOT NULL THEN ''Vendor''  
							END as ReceiveType,
							a.BranchId,
							CASE
								WHEN b.BranchName IS NOT NULL THEN b.BranchName
								ELSE ''-''
							END AS BranchName,
							a.SupplierCode,
							CASE
								WHEN d.SupplierName IS NOT NULL THEN d.SupplierName 
								ELSE ''-''
							END AS SupplierName,
							--a.PIC,
							a.Status,
							a.created_by,
							c.UserName as createdName
						FROM
							IT_ItemIn AS a WITH(NOLOCK)
							LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
							LEFT JOIN MsUsers AS c WITH(NOLOCK) ON a.created_by = c.UserId
							LEFT JOIN MsSupplier AS d WITH(NOLOCK) ON a.SupplierCode = d.SupplierCode		
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							a.ITItemInCode
							DESC
					) AS Qry1
					ORDER BY
						ITItemInCode
						ASC
				) AS Qry2
				ORDER BY
					ITItemInCode
					DESC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 