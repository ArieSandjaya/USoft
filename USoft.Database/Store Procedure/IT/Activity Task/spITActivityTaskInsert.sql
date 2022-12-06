IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityTaskInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityTaskInsert'
	DROP PROCEDURE [dbo].[spITActivityTaskInsert]
END
GO

PRINT 'CREATE PROCEDURE spITActivityTaskInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityTaskInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityTaskInsert
	@povchActivityNo VARCHAR(12) OUTPUT,
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
	
	BEGIN TRAN ActivityTaskInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
		
		IF(
			CONVERT(VARCHAR(8),@pidtmActivityDate,112) > CONVERT(VARCHAR(8),GETDATE(),112)
		)
		BEGIN
			SET @ErrMsg = 'Activity Date should not be a future date.'
			GOTO ExitSP
		END
				
		SELECT @povchActivityNo = dbo.fnGenITActivityNo()
		
		INSERT INTO IT_ActivityTask (
			ActivityNo,
			ActivityDate,
			RequestBy,
			--Email,
			BranchId,
			DepartementCode,
			ProblemTypeCode,
			ItemTypeCode,
			Description,
			IsActive,
			Status,
			Priority,
			created_date,
			created_by
		)
		SELECT
			@povchActivityNo,
			@pidtmActivityDate,
			@pivchRequestBy,
			--@pivchEmail,
			@piintBranchId,
			CASE
				WHEN @pivchDepartementCode = '' THEN NULL
				ELSE @pivchDepartementCode
			END,
			@piintProblemTypeCode,
			CASE
				WHEN @piintProblemTypeCode = 1 THEN @pivchItemTypeCode
				ELSE NULL
			END,
			@pivchDescription,
			1,
			0,
			@pivchPriority,
			GETDATE(),
			@pivchInputID
		
		IF @@ERROR <> 0
			GOTO ExitSP		
		
	COMMIT TRAN ActivityTaskInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskInsert
	END
END
GO

SET NOCOUNT OFF
GO   