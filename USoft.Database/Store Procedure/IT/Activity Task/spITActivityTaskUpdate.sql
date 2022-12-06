IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityTaskUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityTaskUpdate'
	DROP PROCEDURE [dbo].[spITActivityTaskUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITActivityTaskUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityTaskUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityTaskUpdate
	@pivchActivityNo VARCHAR(12),
	@pidtmActivityDate DATETIME,
    @pivchRequestBy VARCHAR(100),
    --@pivchEmail VARCHAR(100),
    @piintBranchId INT,
    @pivchDepartementCode VARCHAR(2),
    @piintProblemTypeCode INT,
    @pivchItemTypeCode VARCHAR(10),
    @pivchDescription VARCHAR(255),
    @pivchPriority VARCHAR(1),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityTaskUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		IF(
			CONVERT(VARCHAR(8),@pidtmActivityDate,112) > CONVERT(VARCHAR(8),GETDATE(),112)
		)
		BEGIN
			SET @ErrMsg = 'Activity Date should not be a future date.'
			GOTO ExitSP
		END	
				
		UPDATE IT_ActivityTask
		SET
			ActivityDate = @pidtmActivityDate,
			RequestBy = @pivchRequestBy,
			--Email = @pivchEmail,
			BranchId = @piintBranchId,
			DepartementCode = CASE
								WHEN @pivchDepartementCode = '' THEN NULL
								ELSE @pivchDepartementCode
							  END,
			ProblemTypeCode = @piintProblemTypeCode,				
			ItemTypeCode = CASE
								WHEN @piintProblemTypeCode = 1 THEN @pivchItemTypeCode
								ELSE NULL
							 END,
			Description = @pivchDescription,
			Priority = @pivchPriority,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ActivityNo = @pivchActivityNo
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityTaskUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskUpdate
	END
END
GO

SET NOCOUNT OFF
GO    