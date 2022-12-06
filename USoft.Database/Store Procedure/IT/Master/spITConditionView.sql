IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITConditionView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITConditionView'
	DROP PROCEDURE [dbo].[spITConditionView]
END
GO

PRINT 'CREATE PROCEDURE spITConditionView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITConditionView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITConditionView		
	@piintConditionCode INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ConditionCode,
		ConditionName,
		IsActive
	FROM
		IT_Condition WITH(NOLOCK)
	WHERE
		ConditionCode = @piintConditionCode
END
GO

SET NOCOUNT OFF
GO     