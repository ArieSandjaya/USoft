IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemCode'
	DROP FUNCTION [dbo].[fnGenItemCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-05-31
**	Description		: Function untuk generate Item Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			'IT'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemCode),4),0) + 1), 4)
	FROM
		IT_Item WITH (NOLOCK)
	WHERE
		ITItemCode LIKE ('IT' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  