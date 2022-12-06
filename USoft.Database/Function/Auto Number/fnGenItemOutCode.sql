IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemOutCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemOutCode'
	DROP FUNCTION [dbo].[fnGenItemOutCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemOutCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemOutCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-13
**	Description		: Function untuk generate Item-Out Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemOutCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'O'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemOutCode),3),0) + 1), 3)
	FROM
		IT_ItemOut WITH (NOLOCK)
	WHERE
		ITItemOutCode LIKE ('O' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  