IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersChangePassword]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersChangePassword'
	DROP PROCEDURE [dbo].[spUsersChangePassword]
END
GO

PRINT 'CREATE PROCEDURE spUsersChangePassword'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersChangePassword / MsChangePassword
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Change Password User Logon
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersChangePassword
	@UserId VARCHAR(50),
	@Pass VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersChangePassword
		DECLARE
			@ErrMsg VARCHAR(2000)
	
		UPDATE
			MsUsers
		SET
			Pass = @Pass,
			ChangePass = 'N' 
		WHERE
			UserId = @UserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
	COMMIT TRAN UsersChangePassword
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersChangePassword
	END
END
GO

SET NOCOUNT OFF
GO         