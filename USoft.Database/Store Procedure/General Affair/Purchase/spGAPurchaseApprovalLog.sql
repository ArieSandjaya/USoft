IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseApprovalLog]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseApprovalLog'
	DROP PROCEDURE [dbo].[spGAPurchaseApprovalLog]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseApprovalLog'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseApprovalLog
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show GA Purchase Approval Log Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseApprovalLog		
	@pivchIDNumber VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ApprovalLogDate,
		CASE
			WHEN a.Status = 'X' THEN 'Reject By ' + b.UserName
			WHEN a.Status = 'A' THEN 'Approved By ' + b.UserName
		END AS StatusLog,
		a.Description
	FROM
		GA_PApprovalLog AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.UserId = b.UserId
	WHERE
		a.IDNumber = @pivchIDNumber
	ORDER BY
		a.ApprovalLogDate DESC
END
GO

SET NOCOUNT OFF
GO  