IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersUpdate'
	DROP PROCEDURE [dbo].[spUsersUpdate]
END
GO

PRINT 'CREATE PROCEDURE spUsersUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersUpdate
	@pivchUserId VARCHAR(50),
    @pivchUserName VARCHAR(100),
    @piintBranchId INT,
    @pivchEmail VARCHAR(50),
    @pivchPass VARCHAR(100),
    @pivchCanSendEmail VARCHAR(1),
    @pivchCanChangePass VARCHAR(1),
    @pivchPrivilegeCode VARCHAR(4),
    @pibitIsActive BIT,
    @pibitIsAllBranch BIT,
    @pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsUsers
		SET
			UserName = @pivchUserName,
			BranchId = @piintBranchId,
			Email = @pivchEmail,
			CanSendMail = @pivchCanSendEmail,
			ChangePass = @pivchCanChangePass,
			IsActive = @pibitIsActive,
			IsAllBranch = @pibitIsAllBranch,
			PrivilegeCode = @pivchPrivilegeCode,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			UserId = @pivchUserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
		-- Update Password
		IF @pivchPass <> ''
		BEGIN
			UPDATE MsUsers
			SET
				Pass = @pivchPass
			WHERE
				UserId = @pivchUserId

			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN UsersInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersInsert
	END
END
GO

SET NOCOUNT OFF
GO     