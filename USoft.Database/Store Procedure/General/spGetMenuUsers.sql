IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMenuUsers]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMenuUsers'
	DROP PROCEDURE [dbo].[spGetMenuUsers]
END
GO

PRINT 'CREATE PROCEDURE spGetMenuUsers'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMenuUsers / MsMenuViewer
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Menu Users
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMenuUsers
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Qry1.UserId,
		Qry1.MenuId,
		Qry2.MenuName,
		Qry2.MenuParent,
		Qry2.MenuLink,
		Qry2.IsActive,
		Qry1.InsertDt,
		Qry1.UpdateDt,
		Qry1.DeleteDt,
		Qry1.ViewDt,
		Qry2.ReportId,
		Qry2.Parameter
	FROM
		(
			SELECT
				UserId,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			FROM
				MsUserMenu WITH(NOLOCK)
			WHERE
				UserId = @pivchUserId

			UNION

			SELECT
				b.UserId,
				a.MenuId,
				a.InsertDt,
				a.UpdateDt,
				a.DeleteDt,
				a.ViewDt
			FROM
				MsPrivilegeDt AS a WITH(NOLOCK)
				INNER JOIN MsUsers AS b WITH(NOLOCK) ON
					a.PrivilegeCode = b.PrivilegeCode
			WHERE
				b.UserId = @pivchUserId
				AND a.MenuId NOT IN (
					select
						MenuId
					from
						MsUserMenu
					where
						UserId = @pivchUserId
				)
		) AS Qry1
		INNER JOIN MsMenu AS Qry2 WITH (nolock) ON
			Qry1.MenuId = Qry2.MenuId
		INNER JOIN MsUsers AS Qry3 WITH (NOLOCK) ON 
			Qry1.UserId = Qry3.UserId
	WHERE
		Qry3.IsActive = 1
		AND Qry2.IsActive = 1
	ORDER BY
		Qry1.MenuId

	/* Previous Version 20130607 dwi
	SELECT
		a.UserId,
		a.MenuId,
		b.MenuName,
		b.MenuParent,
		b.MenuLink,
		b.IsActive,
		a.InsertDt,
		a.UpdateDt,
		a.DeleteDt,
		a.ViewDt,
		b.ReportId,
		b.Parameter
	FROM
		MsUserMenu AS a WITH (nolock)
		INNER JOIN MsMenu AS b WITH (nolock) ON
			a.MenuId = b.MenuId
		INNER JOIN MsUsers AS c WITH (NOLOCK) ON 
			a.UserId = c.UserId
	WHERE
		c.Active = 1
		AND b.IsActive = 1
		AND a.UserId = @pivchUserId
	ORDER BY
		a.MenuId
	*/
END
GO

SET NOCOUNT OFF
GO