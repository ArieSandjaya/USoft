IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementInsert'
	DROP PROCEDURE [dbo].[spDepartementInsert]
END
GO

PRINT 'CREATE PROCEDURE spDepartementInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementInsert
	@pivchDepartementCode VARCHAR(2),
	@pivchDepartementName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN DepartementInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsDepartement WITH(NOLOCK) WHERE DepartementCode = @pivchDepartementCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Departement Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsDepartement (
				DepartementCode,
				DepartementName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchDepartementCode,
				@pivchDepartementName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN DepartementInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN DepartementInsert
	END
END
GO

SET NOCOUNT OFF
GO   