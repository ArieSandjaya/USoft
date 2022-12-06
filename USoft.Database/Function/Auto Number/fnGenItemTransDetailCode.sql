IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemTransDetailCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemTransDetailCode'
	DROP FUNCTION [dbo].[fnGenItemTransDetailCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemTransDetailCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemTransDetailCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-10
**	Description		: Function untuk generate Item Transfer Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemTransDetailCode(@ITItemTransCode varchar(8))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			@ITItemTransCode
			+
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemTransDtlCode),2),0) + 1), 2)
	FROM
		IT_ItemTransDtl WITH (NOLOCK)
	WHERE
		ITItemTransDtlCode LIKE (@ITItemTransCode + '%')
		
	RETURN @NewCode
END
GO  