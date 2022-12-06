IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITActivityAssignInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITActivityAssignInsert'
	DROP PROCEDURE [dbo].[spITActivityAssignInsert]
END
GO

PRINT 'CREATE PROCEDURE spITActivityAssignInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITActivityAssignInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITActivityAssignInsert
	@pivchActivityNo VARCHAR(12),
    @pivchStatus VARCHAR(1),
    @pivchAssignTo VARCHAR(50),
    @pivchAssignDescription VARCHAR(255),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityAssignInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		INSERT INTO IT_ActivityAssign (
			ActivityNo,
			AssignTo,
			AssignFrom,
			StatusAssign,
			DateAssign,
			Description,
			ReAssignID
		)
		SELECT
			@pivchActivityNo,
			CASE
				WHEN @pivchAssignTo = '' THEN NULL
				ELSE @pivchAssignTo
			END,
			@pivchInputID,
			@pivchStatus,
			GETDATE(),
			@pivchAssignDescription,
			NULL
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
		UPDATE
			IT_ActivityTask
		SET
			Status = @pivchStatus,
			ApprovalState = CASE
								WHEN @pivchStatus IN ('2','3') THEN 2
								WHEN @pivchStatus = '4' THEN 3
								ELSE CONVERT(INT,@pivchStatus)
							END,
			PIC = CASE
					WHEN @pivchStatus = '0' THEN NULL -- Re-Open
					WHEN @pivchStatus = '1' THEN @pivchAssignTo
					ELSE PIC
				  END,
			TerminatedBy = CASE
							WHEN @pivchStatus = '0' THEN NULL -- Re-Open
							WHEN @pivchStatus IN ('2','3') THEN @pivchInputID
							ELSE TerminatedBy
						END
			
		WHERE
			ActivityNo = @pivchActivityNo
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityAssignInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityAssignInsert
	END
END
GO

SET NOCOUNT OFF
GO