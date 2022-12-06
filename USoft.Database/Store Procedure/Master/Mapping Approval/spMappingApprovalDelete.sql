 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalDelete'
	DROP PROCEDURE [dbo].[spMappingApprovalDelete]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalDelete
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		-- Delete Email
		DELETE FROM
			MsMappingApprovalMail
		WHERE
			ApprovalID = @piintApprovalID
		
		IF @@ERROR <> 0
			GOTO ExitSP

		-- Delete Mapping
		DELETE FROM
			MsMappingApproval
		WHERE
			ApprovalID = @piintApprovalID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalDelete
	END
END
GO

SET NOCOUNT OFF
GO    