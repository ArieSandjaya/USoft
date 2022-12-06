IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuList'
	DROP PROCEDURE [dbo].[spPrivilegeMenuList]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Privilege Menu Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuList		
	@pivchPrivilegeCode VARCHAR(4),
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.MenuId,
					a.MenuName,
					a.MenuParent,
					a.MenuLink,'

	IF (@pivchPrivilegeCode = '') AND (@pivchUserId = '')
	BEGIN
		SET @sql = @sql + '
					CONVERT(BIT,0) AS InsertDt,
					CONVERT(BIT,0) AS UpdateDt,
					CONVERT(BIT,0) AS DeleteDt,
					CONVERT(BIT,0) AS ViewDt'
	END
	ELSE
	BEGIN
		SET @sql = @sql + '
					CONVERT(BIT,ISNULL(b.InsertDt,0)) AS InsertDt,
					CONVERT(BIT,ISNULL(b.UpdateDt,0)) AS UpdateDt,
					CONVERT(BIT,ISNULL(b.DeleteDt,0)) AS DeleteDt,
					CONVERT(BIT,ISNULL(b.ViewDt,0)) AS ViewDt'
	END
	
	SET @sql = @sql + '
				FROM
					MsMenu AS a WITH(NOLOCK)'
					
	IF (@pivchPrivilegeCode <> '')
	BEGIN
		SET @sql = @sql + '
					LEFT JOIN MsPrivilegeDt AS b WITH(NOLOCK) ON
						a.MenuId = b.MenuId
						AND b.PrivilegeCode = ''' + @pivchPrivilegeCode + ''''
	END
	ELSE IF (@pivchUserId <> '')
	BEGIN
		SET @sql = @sql + '
					LEFT JOIN MsUserMenu AS b WITH(NOLOCK) ON
						a.MenuId = b.MenuId
						AND b.UserId = ''' + @pivchUserId + ''''
	END
				
	SET @sql = @sql + '				
				WHERE
					a.IsActive = 1
				ORDER BY
					a.MenuId'
					
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    