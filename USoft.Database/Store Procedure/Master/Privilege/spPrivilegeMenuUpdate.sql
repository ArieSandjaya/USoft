IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuUpdate'
	DROP PROCEDURE [dbo].[spPrivilegeMenuUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuUpdate
	@pivchPrivilegeCode VARCHAR(4),
	@piintMenuId INT,
	@pibitInsert BIT,
	@pibitUpdate BIT,
	@pibitDelete BIT,
	@pibitView BIT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeMenuUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		-- Delete First, then Insert
		DELETE FROM MsPrivilegeDt
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
			AND MenuId = @piintMenuId
		
		IF @@ERROR <> 0
			GOTO ExitSP
		
		IF
			(@pibitInsert = 1)
			OR (@pibitUpdate = 1)
			OR (@pibitDelete = 1)
			OR (@pibitView = 1)
		BEGIN
			INSERT INTO MsPrivilegeDt (
				PrivilegeCode,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			)
			SELECT
				@pivchPrivilegeCode,
				@piintMenuId,
				@pibitInsert,
				@pibitUpdate,
				@pibitDelete,
				@pibitView
		END
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeMenuUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeMenuUpdate
	END
END
GO

SET NOCOUNT OFF
GO