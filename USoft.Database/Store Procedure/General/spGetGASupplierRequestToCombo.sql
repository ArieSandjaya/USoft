IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetGASupplierRequestToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetGASupplierRequestToCombo'
	DROP PROCEDURE [dbo].[spGetGASupplierRequestToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetGASupplierRequestToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetGASupplierRequestToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data GA Supplier Request To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetGASupplierRequestToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT DISTINCT
			a.SupplierCode
		FROM
			GA_PORequest AS a WITH(NOLOCK)
			INNER JOIN GA_Supplier AS b WITH(NOLOCK) ON
				a.SupplierCode = b.SupplierCode
		WHERE
			a.Status = ''A''
			AND b.IsActive = 1
			AND a.RequestId NOT IN (
					SELECT
						x.RequestId
					FROM
						GA_POrderDtl AS x WITH(NOLOCK)
						INNER JOIN GA_POrder AS y WITH(NOLOCK) ON
							x.OrderId = y.OrderId
					WHERE
						y.Status = ''A''
				)
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   