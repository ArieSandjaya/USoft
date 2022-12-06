IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainInsert'
	DROP PROCEDURE [dbo].[spBranchDomainInsert]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Branch Domain Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainInsert]
	@pivchBranchCode VARCHAR(5),
	@pivchBranchName VARCHAR(100),
	@pivchBranchIP VARCHAR(15),
	@pivchUserName VARCHAR(50),
	@pivchPassword VARCHAR(100),
	@pivchInputID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchDomainInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_DomainServer WITH(NOLOCK) WHERE Branch_Code = @pivchBranchCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO IT_DomainServer (
				Branch_Code,
				Branch_Name,
				Branch_IP,
				UserName,
				Password,
				created_date,
				created_by
			)
			SELECT
				@pivchBranchCode,
				@pivchBranchName,
				@pivchBranchIP,
				@pivchUserName,
				@pivchPassword,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN BranchDomainInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchDomainInsert
	END
END

SET NOCOUNT OFF
GO 