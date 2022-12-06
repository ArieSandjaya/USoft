IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenGAItemNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenGAItemNo'
	DROP FUNCTION [dbo].[fnGenGAItemNo]
END
GO

PRINT 'CREATE FUNCTION fnGenGAItemNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenGAItemNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate GA Item ID
**	Sample			: 20130001
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenGAItemNo()
RETURNS VARCHAR(30)
BEGIN	
	DECLARE
		@NewID VARCHAR(30)

	SELECT
		@NewID = 
			CONVERT(VARCHAR(4),YEAR(GETDATE()))
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ItemCode),4),0) + 1), 4)
	FROM
		GA_Item WITH(NOLOCK)
	WHERE
		ItemCode LIKE (CONVERT(VARCHAR(4),YEAR(GETDATE())) + '%')
		
	RETURN @NewID
END
GO  