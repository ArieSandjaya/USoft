IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainUpdate'
	DROP PROCEDURE [dbo].[spBranchDomainUpdate]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Branch Domain Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainUpdate]
	@pivchBranchCodeOld VARCHAR(5),
	@pivchBranchCode VARCHAR(5),
	@pivchBranchName VARCHAR(100),
	@pivchBranchIP VARCHAR(15),
	@pivchUserName VARCHAR(50),
	@pivchPassword VARCHAR(100),
	@pivchInputID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchDomainUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_DomainServer WITH(NOLOCK)
				WHERE Branch_Code = @pivchBranchCode AND Branch_Code <> @pivchBranchCodeOld
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			UPDATE IT_DomainServer
			SET
				Branch_Code = @pivchBranchCode,
				Branch_Name = @pivchBranchName,
				Branch_IP = @pivchBranchIP,
				UserName = @pivchUserName,
				update_date = GETDATE(),
				update_by = @pivchInputID
			WHERE
				Branch_Code = @pivchBranchCodeOld
		
			IF @@ERROR <> 0
				GOTO ExitSP
				
			IF (@pivchPassword <> '')
			BEGIN
				UPDATE IT_DomainServer
				SET
					Password = @pivchPassword
				WHERE
					Branch_Code = @pivchBranchCode
			END
		END
			
	COMMIT TRAN BranchDomainUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchDomainUpdate
	END
END

SET NOCOUNT OFF
GO