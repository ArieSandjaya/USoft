IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemTransCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemTransCode'
	DROP FUNCTION [dbo].[fnGenItemTransCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemTransCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemTransCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-07
**	Description		: Function untuk generate Item Trans Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemTransCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'T'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemTransCode),3),0) + 1), 3)
	FROM
		IT_ItemTrans WITH (NOLOCK)
	WHERE
		ITItemTransCode LIKE ('T' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  