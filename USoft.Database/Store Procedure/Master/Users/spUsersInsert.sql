IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersInsert'
	DROP PROCEDURE [dbo].[spUsersInsert]
END
GO

PRINT 'CREATE PROCEDURE spUsersInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersInsert
	@pivchUserId VARCHAR(50),
    @pivchUserName VARCHAR(100),
    @piintBranchId INT,
    @pivchEmail VARCHAR(50),
    @pivchPass VARCHAR(100),
    @pivchCanSendEmail VARCHAR(1),
    @pivchCanChangePass VARCHAR(1),
    @pibitIsActive BIT,
    @pibitIsAllBranch BIT,
    @pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsUsers WITH(NOLOCK) WHERE UserId = @pivchUserId
			)
		)
		BEGIN
			SET @ErrMsg = 'User ID already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsUsers (
				UserId,
				UserName,
				BranchId,
				Email,
				Pass,
				CanSendMail,
				ChangePass,
				IsActive,
				IsAllBranch,
				created_date,
				created_by
			)
			SELECT
				@pivchUserId,
				@pivchUserName,
				@piintBranchId,
				@pivchEmail,
				@pivchPass,
				@pivchCanSendEmail,
				@pivchCanChangePass,
				@pibitIsActive,
				@pibitIsAllBranch,
				GETDATE(),
				@pivchInputID
		
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