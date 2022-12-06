IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITProblemTypeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITProblemTypeView'
	DROP PROCEDURE [dbo].[spITProblemTypeView]
END
GO

PRINT 'CREATE PROCEDURE spITProblemTypeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITProblemTypeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-07-03
**	Description		: SP untuk view data IT Problem Type
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITProblemTypeView		
	@pivchProblemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ProblemTypeCode,
		ProblemTypeName,
		IsActive
	FROM
		IT_ProblemType WITH(NOLOCK)
	WHERE
		ProblemTypeCode = @pivchProblemTypeCode
END
GO

SET NOCOUNT OFF
GO      