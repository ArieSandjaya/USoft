IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITConditionToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITConditionToCombo'
	DROP PROCEDURE [dbo].[spGetITConditionToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITConditionToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITConditionToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-30
**	Description		: SP untuk Bind Data IT Condition To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITConditionToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ConditionCode,
			ConditionName
		FROM
			IT_Condition WITH(NOLOCK)
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