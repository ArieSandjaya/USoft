IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeInsert'
	DROP PROCEDURE [dbo].[spPrivilegeInsert]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeInsert
	@pivchPrivilegeCode VARCHAR(4),
	@pivchPrivilegeName VARCHAR(100),
	@pivchDepartementCode VARCHAR(2),
	@pivchOldCode VARCHAR(5),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsPrivilege WITH(NOLOCK) WHERE PrivilegeCode = @pivchPrivilegeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Privilege Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsPrivilege (
				PrivilegeCode,
				PrivilegeName,
				DepartementCode,
				OldCode,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchPrivilegeCode,
				@pivchPrivilegeName,
				@pivchDepartementCode,
				CASE 
					WHEN @pivchOldCode <> '' THEN @pivchOldCode
					ELSE NULL
				END,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN PrivilegeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeInsert
	END
END
GO

SET NOCOUNT OFF
GO    