IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITProblemTypeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITProblemTypeInsert'
	DROP PROCEDURE [dbo].[spITProblemTypeInsert]
END
GO

PRINT 'CREATE PROCEDURE spITProblemTypeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITProblemTypeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-03
**	Description		: SP untuk Insert data IT Problem Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITProblemTypeInsert
	@pivchProblemTypeCode VARCHAR(10),
	@pivchProblemTypeName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITProblemTypeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_ProblemType WITH(NOLOCK) 
				WHERE ProblemTypeCode = @pivchProblemTypeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Problem Type Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO IT_ProblemType (
				ProblemTypeCode,
				ProblemTypeName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchProblemTypeCode,
				@pivchProblemTypeName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ITProblemTypeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITProblemTypeInsert
	END
END
GO

SET NOCOUNT OFF
GO      