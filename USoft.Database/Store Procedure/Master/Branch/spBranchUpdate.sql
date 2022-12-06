IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchUpdate'
	DROP PROCEDURE [dbo].[spBranchUpdate]
END
GO

PRINT 'CREATE PROCEDURE spBranchUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Update Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchUpdate
	@piintBranchId INT,
	@pivchBranchCode VARCHAR(20),
	@pivchBranchName VARCHAR(50),
	@piintBranchType INT,
	@piintBranchParent INT,
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsBranch
		SET
			BranchCode = @pivchBranchCode,
			BranchName = @pivchBranchName,
			BranchType = @piintBranchType,
			BranchParent = 
					CASE 
						WHEN @piintBranchParent = 0 THEN NULL
						ELSE @piintBranchParent
					END,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			BranchId = @piintBranchId
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN BranchUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchUpdate
	END
END
GO

SET NOCOUNT OFF
GO    