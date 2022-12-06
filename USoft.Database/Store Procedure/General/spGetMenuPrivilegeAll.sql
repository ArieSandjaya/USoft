IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMenuPrivilegeAll]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMenuPrivilegeAll'
	DROP PROCEDURE [dbo].[spGetMenuPrivilegeAll]
END
GO

PRINT 'CREATE PROCEDURE spGetMenuPrivilegeAll'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMenuPrivilegeAll / MsMenuPrivGetAll
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Menu Tree Privilege
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMenuPrivilegeAll
	@PrivCode VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON
	
	IF OBJECT_ID('tempdb..#tblmenus') IS NOT NULL
	BEGIN
		DROP TABLE #tblmenus
	END
	ELSE
	BEGIN
		CREATE TABLE #tblmenus(MenuId int,
							   MenuName varchar(50),
							   MenuParent int,
							   MenuLink varchar(100),
							   ReportId varchar(50),
							   InsertDt bit,
							   UpdateDt bit,
							   DeleteDt bit,
							   ViewDt bit)
	END
		
	INSERT INTO #tblmenus(
		MenuId,
		MenuName,
		MenuParent,
		MenuLink,
		ReportId
	)
	SELECT
		MenuId,
		MenuName,
		MenuParent,
	    MenuLink,
	    ReportId
	FROM
		MsMenu WITH (NOLOCK)
	ORDER BY
		MenuId
		
	UPDATE
		#tblmenus
	SET
		-- Replace by dwi 20130607
		/*
		InsertDt = MsPriveledgeDt.InsertDt,
		UpdateDt = MsPriveledgeDt.UpdateDt,
		DeleteDt = MsPriveledgeDt.DeleteDt,
		ViewDt = MsPriveledgeDt.ViewDt
		*/
		InsertDt = MsPrivilegeDt.InsertDt,
		UpdateDt = MsPrivilegeDt.UpdateDt,
		DeleteDt = MsPrivilegeDt.DeleteDt,
		ViewDt = MsPrivilegeDt.ViewDt
	FROM
		--MsPriveledgeDt
		MsPrivilegeDt
	WHERE
		--#tblmenus.MenuId = MsPriveledgeDt.MenuId
		--AND MsPriveledgeDt.PriveledgeCode = @PrivCode
		#tblmenus.MenuId = MsPrivilegeDt.MenuId
		AND MsPrivilegeDt.PrivilegeCode = @PrivCode

	SELECT
		MenuId,
		MenuName,
		MenuParent,
		MenuLink,
		ReportId,
		CASE WHEN ISNULL(InsertDt,0) = 0 THEN 'false' ELSE 'true' END InsertDt,
		CASE WHEN ISNULL(UpdateDt,0) = 0 THEN 'false' ELSE 'true' END UpdateDt,
		CASE WHEN ISNULL(DeleteDt,0) = 0 THEN 'false' ELSE 'true' END DeleteDt,
		CASE WHEN ISNULL(ViewDt,0) = 0 THEN 'false' ELSE 'true' END ViewDt
	FROM
		#tblmenus
END
GO

SET NOCOUNT OFF
GO