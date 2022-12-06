IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementUpdate'
	DROP PROCEDURE [dbo].[spDepartementUpdate]
END
GO

PRINT 'CREATE PROCEDURE spDepartementUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementUpdate
	@pivchDepartementCode VARCHAR(2),
	@pivchDepartementName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN DepartementUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsDepartement
		SET
			DepartementName = @pivchDepartementName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			DepartementCode = @pivchDepartementCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN DepartementUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN DepartementUpdate
	END
END
GO

SET NOCOUNT OFF
GO   