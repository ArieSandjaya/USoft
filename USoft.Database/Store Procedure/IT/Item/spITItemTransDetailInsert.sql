IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailInsert'
	DROP PROCEDURE [dbo].[spITItemTransDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-06-10
**	Description		: SP untuk Insert data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailInsert
	@pivchItemTransCode VARCHAR(8),
	@pivchItemCode VARCHAR(10),
	@piintConditionCode INT,
	@pivchUsedBy VARCHAR(50),
	@pivchPrivilegeCode VARCHAR(4),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@povchItemTransDetailCode VARCHAR(10)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_ItemTransDtl WITH(NOLOCK)
				WHERE
					ITItemTransCode = @pivchItemTransCode
					AND ITItemCode = @pivchItemCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Item already in database'
			GOTO ExitSP
		END
		
		INSERT INTO IT_ItemTransDtl (
			ITItemTransDtlCode,
			ITItemTransCode,
			ITItemCode,
			ConditionCode,
			UsedBy,
			PrivilegeCode,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemTransDetailCode(@pivchItemTransCode),
			@pivchItemTransCode,
			@pivchItemCode,
			@piintConditionCode,
			CASE
				WHEN @pivchUsedBy = '' THEN NULL
				ELSE @pivchUsedBy
			END,
			CASE
				WHEN @pivchPrivilegeCode = '' THEN NULL
				ELSE @pivchPrivilegeCode
			END,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransDetailInsert
	RETURN --@povchItemInDetailCode
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO    