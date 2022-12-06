IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserToCombo'
	DROP PROCEDURE [dbo].[spGetUserToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetUserToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data User To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			UserId,
			UserName
		FROM
			MsUsers WITH(NOLOCK)
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