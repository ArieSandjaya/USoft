IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestApprovalList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestApprovalList'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestApprovalList]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestApprovalList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestApprovalList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Request Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestApprovalList		
	@pivchWhereBy VARCHAR(1000),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE
		@sql VARCHAR(2000),
		@sqlWhere VARCHAR(2000)
		
	IF (@pivchWhereBy <> '')
		SET @pivchWhereBy = @pivchWhereBy + ' AND '
	
	SET @pivchWhereBy = ISNULL(@pivchWhereBy,'') + '(a.Status IN (''R'',''A'')) AND (a.ApprovalState > 1)'
		
	EXEC spGAPurchaseRequestList
		@pivchWhereBy,
		@piintPageNo,
		@piintPageSize,
		@pointTotalPage OUTPUT,
		@pointTotalData OUTPUT
END
GO

SET NOCOUNT OFF
GO  