IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseRequestNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseRequestNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseRequestNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseRequestNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseRequestNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Purchase Order ID
**	Sample			: 001/Purch/GA/HO/I/2013
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseRequestNo()
RETURNS VARCHAR(30)
BEGIN	
	DECLARE
		@NewID VARCHAR(30),
		@TempID VARCHAR(30)

	SELECT @TempID = '/Purch/GA/HO/' + dbo.fnConvertIntToRoman(MONTH(GETDATE())) + '/' + CONVERT(VARCHAR(4),GETDATE(),112)

	SELECT
		@NewID = 
			RIGHT('000' + CONVERT(VARCHAR,LEFT(ISNULL(MAX(RequestId),0),3) + 1), 3) + @TempID
	FROM
		GA_PORequest WITH(NOLOCK)
	WHERE
		RequestId LIKE '%' + @TempID
		
	RETURN @NewID
END
GO