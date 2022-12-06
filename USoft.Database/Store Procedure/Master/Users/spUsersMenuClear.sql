IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersMenuClear]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersMenuClear'
	DROP PROCEDURE [dbo].[spUsersMenuClear]
END
GO

PRINT 'CREATE PROCEDURE spUsersMenuClear'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersMenuClear
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Clear Users Menu Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersMenuClear
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersMenuClear
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM MsUserMenu
		WHERE
			UserId = @pivchUserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN UsersMenuClear
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersMenuClear
	END
END
GO

SET NOCOUNT OFF
GO 