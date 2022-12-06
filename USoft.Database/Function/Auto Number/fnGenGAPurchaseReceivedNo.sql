IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseReceivedNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseReceivedNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseReceivedNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseReceivedNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseReceivedNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Purchase Received ID
**	Sample			: 096/PR/GA-Dept/IV/2013
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseReceivedNo()
RETURNS VARCHAR(30)
BEGIN	
	DECLARE
		@NewID VARCHAR(30),
		@TempID VARCHAR(30)

	SELECT @TempID = '/PR/GA-Dept/' + dbo.fnConvertIntToRoman(MONTH(GETDATE())) + '/' + CONVERT(VARCHAR(4),GETDATE(),112)

	SELECT
		@NewID = 
			RIGHT('000' + CONVERT(VARCHAR,LEFT(ISNULL(MAX(ReceivedId),0),3) + 1), 3) + @TempID
	FROM
		GA_POReceived WITH(NOLOCK)
	WHERE
		ReceivedId LIKE '%' + @TempID
		
	RETURN @NewID
END
GO  