IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAPurchaseOrderDetailNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAPurchaseOrderDetailNo'
	DROP FUNCTION [dbo].[fnGenGAPurchaseOrderDetailNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAPurchaseOrderDetailNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAPurchaseOrderDetailNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-30
**	Description		: Function untuk generate Purchase Order Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAPurchaseOrderDetailNo(@OrderId varchar(30))
RETURNS VARCHAR(40)
BEGIN
	DECLARE @NewCode VARCHAR(40)

	SELECT
		@NewCode = 
			@OrderId
			+ '-' +
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(OrderDetailId),2),0) + 1), 2)
	FROM
		GA_POrderDtl WITH (NOLOCK)
	WHERE
		OrderDetailId LIKE (@OrderId + '-%')
	
	RETURN @NewCode
END
GO 