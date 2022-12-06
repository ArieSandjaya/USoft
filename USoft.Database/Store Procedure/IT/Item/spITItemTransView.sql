 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransView'
	DROP PROCEDURE [dbo].[spITItemTransView]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show detail data Item Transfer 
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransView		
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemTransCode,
		a.BranchId_From,
		ISNULL(b.BranchName,'Warehouse') AS BranchNameFrom,
		a.BranchId_To,
		ISNULL(c.BranchName,'Warehouse') AS BranchNameTo,
		a.DateTrans,
		a.Status,
		a.created_by AS CreatedBy,
		d.UserName AS CreatedName,
		a.ApprovalState
	FROM
		IT_ItemTrans AS a WITH(NOLOCK)
		LEFT JOIN MsBranch AS b WITH(NOLOCK) ON b.BranchId = a.BranchId_From
		LEFT JOIN MsBranch AS c WITH(NOLOCK) ON c.BranchId = a.BranchId_To
		LEFT JOIN MsUsers AS d WITH(NOLOCK) ON a.created_by = d.UserId
	WHERE
		a.ITItemTransCode = @pivchItemTransCode
		
END
GO

SET NOCOUNT OFF
GO   