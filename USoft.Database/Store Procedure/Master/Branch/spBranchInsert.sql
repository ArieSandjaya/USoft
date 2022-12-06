IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchInsert'
	DROP PROCEDURE [dbo].[spBranchInsert]
END
GO

PRINT 'CREATE PROCEDURE spBranchInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Insert Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchInsert
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
	
	BEGIN TRAN BranchInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsBranch WITH(NOLOCK) 
				WHERE BranchId = @piintBranchId 
					AND BranchCode =  @pivchBranchCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Id or Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsBranch (
				BranchId,
				BranchCode,
				BranchName,
				BranchType,
				BranchParent,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@piintBranchId, 
				@pivchBranchCode,
				@pivchBranchName,
				@piintBranchType,
				CASE 
					WHEN @piintBranchParent = 0 THEN NULL
					ELSE @piintBranchParent
				END,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN BranchInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchInsert
	END
END
GO

SET NOCOUNT OFF
GO    