IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITProblemTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITProblemTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITProblemTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITProblemTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITProblemTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-29
**	Description		: SP untuk Bind Data Problem Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITProblemTypeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ProblemTypeCode,
			ProblemTypeName
		FROM
			IT_ProblemType WITH(NOLOCK)
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