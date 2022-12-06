IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailUpdate'
	DROP PROCEDURE [dbo].[spITItemTransDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Update data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailUpdate
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8),
	@pivchItemCode VARCHAR(10),
	@piintConditionCode INT,
	@pivchUsedBy VARCHAR(50),
	@pivchPrivilegeCode VARCHAR(4),
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_ItemTransDtl WITH(NOLOCK)
				WHERE
					ITItemTransCode = @pivchItemTransCode
					AND ITItemCode = @pivchItemCode
					AND ITItemTransDtlCode <> @pivchItemTransDetailCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Item already in database'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemTransDtl
		SET
			ITItemCode=@pivchItemCode,
			ConditionCode=@piintConditionCode,
			UsedBy= CASE
						WHEN @pivchUsedBy = '' THEN NULL
						ELSE @pivchUsedBy
					END,
			PrivilegeCode=  CASE
								WHEN @pivchPrivilegeCode = '' THEN NULL
								ELSE @pivchPrivilegeCode
							END,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ITItemTransDtlCode = @pivchItemTransDetailCode
			and ITItemTransCode = @pivchItemTransCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO     