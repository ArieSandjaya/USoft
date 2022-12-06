 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITProblemTypeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITProblemTypeUpdate'
	DROP PROCEDURE [dbo].[spITProblemTypeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITProblemTypeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITProblemTypeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-03
**	Description		: SP untuk Update data IT Problem Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITProblemTypeUpdate
	@pivchProblemTypeCode VARCHAR(10),
	@pivchProblemTypeName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITProblemTypeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_ProblemType
		SET
			ProblemTypeName = @pivchProblemTypeName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ProblemTypeCode = @pivchProblemTypeCode
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITProblemTypeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITProblemTypeUpdate
	END
END
GO

SET NOCOUNT OFF
GO      