IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailInsert'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailInsert]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Mapping Approval E-Mail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailInsert
	@piintApprovalID INT,
    @pivchUserIdEmail VARCHAR(50),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalEmailInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		IF(
			EXISTS(
				SELECT ''
				FROM MsMappingApprovalMail WITH(NOLOCK)
				WHERE
					ApprovalID = @piintApprovalID
					AND UserEmail = @pivchUserIdEmail
			)
		)
		BEGIN
			SET @ErrMsg = 'User E-Mail already in list'
			GOTO ExitSP
		END
		
		INSERT INTO MsMappingApprovalMail (
			ApprovalID,
			UserEmail,
			created_date,
			created_by
		)
		SELECT
			@piintApprovalID,
			@pivchUserIdEmail,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalEmailInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalEmailInsert
	END
END
GO

SET NOCOUNT OFF
GO    