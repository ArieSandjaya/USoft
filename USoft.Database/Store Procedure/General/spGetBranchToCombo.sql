IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranchToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranchToCombo'
	DROP PROCEDURE [dbo].[spGetBranchToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetBranchToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranchToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Branch To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranchToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			BranchId,
			BranchName
		FROM
			MsBranch WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO     