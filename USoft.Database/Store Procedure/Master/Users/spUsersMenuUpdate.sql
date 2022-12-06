IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersMenuUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersMenuUpdate'
	DROP PROCEDURE [dbo].[spUsersMenuUpdate]
END
GO

PRINT 'CREATE PROCEDURE spUsersMenuUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersMenuUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersMenuUpdate
	@pivchUserId VARCHAR(50),
	@piintMenuId INT,
	@pibitInsert BIT,
	@pibitUpdate BIT,
	@pibitDelete BIT,
	@pibitView BIT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersMenuUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		-- Delete first, then insert
		DELETE FROM MsUserMenu
		WHERE
			UserId = @pivchUserId
			AND MenuId = @piintMenuId
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
		IF
			(@pibitInsert = 1)
			OR (@pibitUpdate = 1)
			OR (@pibitDelete = 1)
			OR (@pibitView = 1)
		BEGIN
			INSERT INTO MsUserMenu (
				UserId,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			)
			SELECT
				@pivchUserId,
				@piintMenuId,
				@pibitInsert,
				@pibitUpdate,
				@pibitDelete,
				@pibitView
		END
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN UsersMenuUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersMenuUpdate
	END
END
GO

SET NOCOUNT OFF
GO 