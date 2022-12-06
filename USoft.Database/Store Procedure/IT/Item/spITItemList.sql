IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemList'
	DROP PROCEDURE [dbo].[spITItemList]
END
GO

PRINT 'CREATE PROCEDURE spITItemList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk show data List Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemList]		
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
					IT_Item A WITH(NOLOCK)
					INNER JOIN IT_ItemType B WITH(NOLOCK) ON A.ItemTypeCode = B.ItemTypeCode	
					INNER JOIN IT_Condition C WITH(NOLOCK)  ON A.ConditionCode = C.ConditionCode
					LEFT JOIN MsBranch D WITH(NOLOCK)  ON A.BranchId = D.BranchId
					LEFT JOIN MsPrivilege E WITH(NOLOCK)  ON A.PrivilegeCode = E.PrivilegeCode
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
							A.ITItemCode,
							A.ITItemInDtlCode,
							A.ItemTypeCode,
							B.ItemTypeName,
							A.SerialNo,
							A.Barcode,
							A.Description,
							A.ConditionCode,
							C.ConditionName,
							A.StatusIn,
							A.StatusOut,
							A.BranchId,
							D.BranchCode,
							ISNULL(D.BranchName,''Warehouse'') AS BranchName,
							A.UsedBy,
							E.PrivilegeName,
							CASE
								WHEN A.IsActive = 1 THEN ''Active''
								ELSE ''Non Active''
							END AS IsActive
						FROM
							IT_Item A WITH(NOLOCK)
							INNER JOIN IT_ItemType B WITH(NOLOCK) ON A.ItemTypeCode = B.ItemTypeCode	
							INNER JOIN IT_Condition C WITH(NOLOCK)  ON A.ConditionCode = C.ConditionCode
							LEFT JOIN MsBranch D WITH(NOLOCK)  ON A.BranchId = D.BranchId
							LEFT JOIN MsPrivilege E WITH(NOLOCK)  ON A.PrivilegeCode = E.PrivilegeCode		
						' + ISNULL(@sqlWhere,'') + '
						ORDER BY 
							A.ITItemCode
							DESC
					) AS Qry1
					ORDER BY
						ITItemCode
						ASC
				) AS Qry2
				ORDER BY
					ITItemCode
					DESC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  