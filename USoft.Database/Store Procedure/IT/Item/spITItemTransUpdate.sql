IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransUpdate'
	DROP PROCEDURE [dbo].[spITItemTransUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk Update Data Item Transfer hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransUpdate
	@pivchItemTransCode VARCHAR(8),
	@piintBranchFrom INT,
	@piintBranchTo INT,
	@pidtmDateTrans DATETIME,
	@pivchInputID VARCHAR(50)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(@piintBranchFrom = @piintBranchTo)
		BEGIN
			SET @ErrMsg = 'Invalid Destination Branch, Branch To cannot same with Branch From'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemTrans
		SET
			BranchId_From = CASE
								WHEN @piintBranchFrom = 0 THEN NULL
								ELSE @piintBranchFrom
							END,
			BranchId_To = CASE
								WHEN @piintBranchTo = 0 THEN NULL
								ELSE @piintBranchTo
							END,
			DateTrans = @pidtmDateTrans,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ITItemTransCode = @pivchItemTransCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransUpdate
	END
END
GO

SET NOCOUNT OFF
GO     