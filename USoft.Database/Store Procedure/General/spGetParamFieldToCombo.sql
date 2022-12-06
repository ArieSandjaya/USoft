IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetParamFieldToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetParamFieldToCombo'
	DROP PROCEDURE [dbo].[spGetParamFieldToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetParamFieldToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetParamFieldToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Field Search To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetParamFieldToCombo		
	@pivchMenuID VARCHAR(6)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ParamName,
			ParamType + ''|'' + ParamField AS ParamField
		FROM
			MsMenuSearch WITH(NOLOCK)
		WHERE
			IsActive = 1
			AND MenuID = ''' + @pivchMenuID + '''
		ORDER BY
			SequenceNo
	'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    