IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranchDomainToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranchDomainToCombo'
	DROP PROCEDURE [dbo].[spGetBranchDomainToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetBranchDomainToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranchDomainToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Branch Domain To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranchDomainToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			Branch_Code,
			Branch_Name
		FROM
			IT_DomainServer WITH(NOLOCK)
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      