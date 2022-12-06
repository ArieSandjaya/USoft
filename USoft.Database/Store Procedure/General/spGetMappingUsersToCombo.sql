IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingUsersToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingUsersToCombo'
	DROP PROCEDURE [dbo].[spGetMappingUsersToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingUsersToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingUsersToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Mapping User To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingUsersToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			a.UserId,
			b.UserName
		FROM
			MsMappingUsers AS a WITH(NOLOCK)
			INNER JOIN MsUsers AS b WITH(NOLOCK) ON
				a.UserId = b.UserId
		WHERE
			a.IsActive = 1
			AND b.IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      