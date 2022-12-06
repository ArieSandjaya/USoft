IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseReceivedDetailNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseReceivedDetailNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseReceivedDetailNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseReceivedDetailNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseReceivedDetailNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-30
**	Description		: Function untuk generate Purchase Received Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseReceivedDetailNo(@ReceivedId varchar(30))
RETURNS VARCHAR(40)
BEGIN
	DECLARE @NewCode VARCHAR(40)

	SELECT
		@NewCode = 
			@ReceivedId
			+ '-' +
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ReceivedDetailId),2),0) + 1), 2)
	FROM
		GA_POReceivedDtl WITH (NOLOCK)
	WHERE
		ReceivedDetailId LIKE (@ReceivedId + '-%')
	
	RETURN @NewCode
END
GO  