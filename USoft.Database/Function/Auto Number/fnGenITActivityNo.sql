IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenITActivityNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenITActivityNo'
	DROP FUNCTION [dbo].[fnGenITActivityNo]
END
GO

PRINT 'CREATE FUNCTION fnGenITActivityNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenITActivityNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Activity Number
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenITActivityNo()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewID VARCHAR(10)

	SELECT
		@NewID = 
			CONVERT(VARCHAR,YEAR(GETDATE()))
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(MAX(ActivityNo),0) + 1), 4)
	FROM
		IT_ActivityTask WITH(NOLOCK)
	WHERE
		ActivityNo LIKE CONVERT(VARCHAR,YEAR(GETDATE()))+'%'
		
	RETURN @NewID
END
GO 