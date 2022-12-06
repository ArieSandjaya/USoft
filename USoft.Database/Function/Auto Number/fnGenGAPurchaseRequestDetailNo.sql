IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseRequestDetailNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseRequestDetailNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseRequestDetailNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseRequestDetailNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseRequestDetailNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-30
**	Description		: Function untuk generate Purchase Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseRequestDetailNo(@RequestId varchar(30))
RETURNS VARCHAR(40)
BEGIN
	DECLARE @NewCode VARCHAR(40)

	SELECT
		@NewCode = 
			@RequestId
			+ '-' +
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(RequestDetailId),2),0) + 1), 2)
	FROM
		GA_PORequestDtl WITH (NOLOCK)
	WHERE
		RequestDetailId LIKE (@RequestId + '-%')
	
	RETURN @NewCode
END
GO