IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemInDetailCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemInDetailCode'
	DROP FUNCTION [dbo].[fnGenItemInDetailCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemInDetailCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemInDetailCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-30
**	Description		: Function untuk generate Item-In Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemInDetailCode(@ITItemInCode varchar(8))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			@ITItemInCode
			+
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemInDtlCode),2),0) + 1), 2)
	FROM
		IT_ItemInDtl WITH (NOLOCK)
	WHERE
		ITItemInDtlCode LIKE (@ITItemInCode + '%')
		
	RETURN @NewCode
END
GO  