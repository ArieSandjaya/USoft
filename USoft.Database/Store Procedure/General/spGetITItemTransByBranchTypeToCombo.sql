IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemTransByBranchTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemTransByBranchTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemTransByBranchTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemTransByBranchTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemTransByBranchTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Bind Data Item by Branch and Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemTransByBranchTypeToCombo
	@pivchITItemTransCode VARCHAR(8),
	@pivchItemTypeCode VARCHAR(10),
	@pivchITItemCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemCode,
		a.SerialNo + ' / ' + a.Barcode + ' / ' + a.Description AS ItemName,
		a.ConditionCode
	FROM
		IT_Item AS a WITH(NOLOCK)
		INNER JOIN IT_ItemTrans AS b WITH(NOLOCK) ON
			ISNULL(a.BranchId,0) = ISNULL(b.BranchId_From,0)
	WHERE
		a.IsActive = 1 
		AND a.ITItemOutCode IS NULL	
		AND b.ITItemTransCode = @pivchITItemTransCode
		AND a.ItemTypeCode = @pivchItemTypeCode
		AND a.ITItemCode NOT IN (
			SELECT
				ITItemCode
			FROM
				IT_ItemTransDtl WITH(NOLOCK)
			WHERE
				ITItemTransCode = @pivchITItemTransCode
				AND (
					@pivchITItemCode IS NULL
					OR
					ITItemCode <> @pivchITItemCode
				)
		)
END
GO