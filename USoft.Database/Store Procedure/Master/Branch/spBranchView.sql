IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchView'
	DROP PROCEDURE [dbo].[spBranchView]
END
GO

PRINT 'CREATE PROCEDURE spBranchView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchView		
	@piintBranchId INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		BranchId,
		BranchCode,
		BranchName,
		BranchType,
		BranchParent,
		IsActive
	FROM
		MsBranch WITH(NOLOCK)
	WHERE
		BranchId = @piintBranchId
END
GO

SET NOCOUNT OFF
GO    