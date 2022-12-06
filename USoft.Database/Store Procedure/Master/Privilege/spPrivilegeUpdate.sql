IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeUpdate'
	DROP PROCEDURE [dbo].[spPrivilegeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeUpdate
	@pivchPrivilegeCode VARCHAR(4),
	@pivchPrivilegeName VARCHAR(100),
	@pivchDepartementCode VARCHAR(2),
	@pivchOldCode VARCHAR(5),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsPrivilege
		SET
			PrivilegeName = @pivchPrivilegeName,
			DepartementCode = @pivchDepartementCode,
			OldCode = 
				CASE 
					WHEN @pivchOldCode <> '' THEN @pivchOldCode
					ELSE NULL
				END,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeUpdate
	END
END
GO

SET NOCOUNT OFF
GO    