IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwMsMenu]'))
BEGIN
	PRINT 'DROP VIEW vwMsMenu'
	DROP VIEW [dbo].[vwMsMenu]
END
GO

PRINT 'CREATE VIEW vwMsMenu'
GO

/*---------------------------------------------------------------------------
**	View Name		: vwMsMenu / MsMenuView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: View untuk Data Menu
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE VIEW vwMsMenu
AS
	SELECT
		UM.UserId,
		UM.MenuId,
		MM.MenuName,
		MM.MenuParent,
		MM.MenuLink,
		MM.IsActive,
		UM.InsertDt,
		UM.UpdateDt,
		UM.DeleteDt,
		UM.ViewDt,
		MM.ReportId,
		MM.Parameter
	FROM
		dbo.MsUserMenu AS UM WITH (nolock)
		INNER JOIN dbo.MsMenu AS MM WITH (nolock) ON
			UM.MenuId = MM.MenuId
GO