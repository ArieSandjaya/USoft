IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuClear]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuClear'
	DROP PROCEDURE [dbo].[spPrivilegeMenuClear]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuClear'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuClear
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Clear Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuClear
	@pivchPrivilegeCode VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeMenuClear
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM MsPrivilegeDt
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeMenuClear
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeMenuClear
	END
END
GO

SET NOCOUNT OFF
GO 