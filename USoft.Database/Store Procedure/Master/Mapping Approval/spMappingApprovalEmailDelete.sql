 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailDelete'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailDelete]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Mapping Approval E-Mail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailDelete
	@piintApprovalEmailID INT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalEmailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		-- Delete Email
		DELETE FROM
			MsMappingApprovalMail
		WHERE
			ApprovalEmailID = @piintApprovalEmailID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalEmailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalEmailDelete
	END
END
GO

SET NOCOUNT OFF
GO     