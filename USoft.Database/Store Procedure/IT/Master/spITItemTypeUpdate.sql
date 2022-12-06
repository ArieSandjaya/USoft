 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTypeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTypeUpdate'
	DROP PROCEDURE [dbo].[spITItemTypeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemTypeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTypeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-07-03
**	Description		: SP untuk Update data IT Item Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTypeUpdate
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(50),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemTypeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_ItemType
		SET
			ItemTypeName = @pivchItemTypeName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ItemTypeCode = @pivchItemTypeCode
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITItemTypeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemTypeUpdate
	END
END
GO

SET NOCOUNT OFF
GO     