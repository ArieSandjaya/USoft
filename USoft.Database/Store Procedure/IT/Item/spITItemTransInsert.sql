IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransInsert'
	DROP PROCEDURE [dbo].[spITItemTransInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk Insert Item Transfer hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransInsert
	@povchItemTransCode VARCHAR(8) OUTPUT,
	@piintBranchFrom INT,
	@piintBranchTo INT,
	@pidtmDateTrans DATETIME,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransInsert
		DECLARE
			@ErrMsg VARCHAR(2000)

		SELECT @povchItemTransCode = dbo.fnGenItemTransCode()


		IF(@piintBranchFrom = @piintBranchTo)
		BEGIN
			SET @ErrMsg = 'Invalid Destination Branch, Branch To cannot same with Branch From'
			GOTO ExitSP
		END
		
		INSERT INTO IT_ItemTrans (
			ITItemTransCode,
			BranchId_From,
			BranchId_To,
			DateTrans,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			@povchItemTransCode,
			CASE
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			CASE
				WHEN @piintBranchTo = 0 THEN NULL
				ELSE @piintBranchTo
			END,
			@pidtmDateTrans,
			'D',
			0,
			GETDATE(),
			@pivchInputID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransInsert
	END
END
GO

SET NOCOUNT OFF
GO    