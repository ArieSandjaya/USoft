IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemByBranchTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemByBranchTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemByBranchTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemByBranchTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemByBranchTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Bind Data Item by Branch and Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemByBranchTypeToCombo
	@piintBranchId INT,
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@pivchItemTypeCode <> '') -- Harus dipilih kedua nya
	BEGIN	
		SELECT
			ITItemCode,
			SerialNo + ' / ' + Barcode + ' / ' + Description AS ItemName
		FROM
			IT_Item WITH(NOLOCK)
		WHERE
			IsActive = 1 -- Is not repair/dispose
			AND ITItemOutCode IS NULL
			AND ItemTypeCode = @pivchItemTypeCode
			AND ISNULL(BranchId,0) = @piintBranchId
	END
END
GO 