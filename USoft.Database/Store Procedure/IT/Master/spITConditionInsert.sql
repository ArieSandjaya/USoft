IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITConditionInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITConditionInsert'
	DROP PROCEDURE [dbo].[spITConditionInsert]
END
GO

PRINT 'CREATE PROCEDURE spITConditionInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITConditionInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Insert Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITConditionInsert
	@piintConditionCode INT,
	@pivchConditionName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ConditionInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_Condition WITH(NOLOCK) 
				WHERE ConditionCode =  @piintConditionCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Condition Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO IT_Condition (
				ConditionCode,
				ConditionName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@piintConditionCode,
				@pivchConditionName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ConditionInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ConditionInsert
	END
END
GO

SET NOCOUNT OFF
GO     