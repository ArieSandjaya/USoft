IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemInCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemInCode'
	DROP FUNCTION [dbo].[fnGenItemInCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemInCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemInCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Item-In Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemInCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'I'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemInCode),3),0) + 1), 3)
	FROM
		IT_ItemIn WITH (NOLOCK)
	WHERE
		ITItemInCode LIKE ('I' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO 