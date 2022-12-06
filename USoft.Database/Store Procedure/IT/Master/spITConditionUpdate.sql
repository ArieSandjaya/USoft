IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITConditionUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITConditionUpdate'
	DROP PROCEDURE [dbo].[spITConditionUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITConditionUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITConditionUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Update Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITConditionUpdate
	@piintConditionCode INT,
    @pivchConditionName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ConditionUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_Condition
		SET
			ConditionCode = @piintConditionCode,
            ConditionName = @pivchConditionName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ConditionCode = @piintConditionCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ConditionUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ConditionUpdate
	END
END
GO

SET NOCOUNT OFF
GO     