IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseOrderNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseOrderNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseOrderNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseOrderNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseOrderNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Purchase Order ID
**	Sample			: 096/OP/GA-Dept/IV/2013
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseOrderNo()
RETURNS VARCHAR(30)
BEGIN	
	DECLARE
		@NewID VARCHAR(30),
		@TempID VARCHAR(30)

	SELECT @TempID = '/OP/GA-Dept/' + dbo.fnConvertIntToRoman(MONTH(GETDATE())) + '/' + CONVERT(VARCHAR(4),GETDATE(),112)

	SELECT
		@NewID = 
			RIGHT('000' + CONVERT(VARCHAR,LEFT(ISNULL(MAX(OrderId),0),3) + 1), 3) + @TempID
	FROM
		GA_POrder WITH(NOLOCK)
	WHERE
		OrderId LIKE '%' + @TempID
		
	RETURN @NewID
END
GO 