IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenSupplierCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenSupplierCode'
	DROP FUNCTION [dbo].[fnGenSupplierCode]
END
GO

PRINT 'CREATE FUNCTION fnGenSupplierCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenSupplierCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Item-In Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenSupplierCode(@Index VARCHAR(6))
RETURNS VARCHAR(6)
BEGIN
	DECLARE
		@MaxCode VARCHAR(6),
		@NewCode VARCHAR(6),
		@IdxLen INT
			
	SELECT @IdxLen = LEN(@Index)
	
	SELECT
		@MaxCode = ISNULL(MAX(SupplierCode),0)
	FROM
		MsSupplier WITH (NOLOCK)
	WHERE
		SupplierCode LIKE (@Index + '%')

	
	SELECT
		@NewCode = 
			@Index
			+
			RIGHT('000000' + CONVERT(VARCHAR,ISNULL(RIGHT(@MaxCode,6-LEN(@Index)),0) + 1), 6-LEN(@Index))	
		
	RETURN @NewCode
END
GO 