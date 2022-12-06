IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnConvertIntToRoman]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnConvertIntToRoman'
	DROP FUNCTION [dbo].[fnConvertIntToRoman]
END
GO

PRINT 'CREATE FUNCTION fnConvertIntToRoman'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnConvertIntToRoman
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function for convert INT to Roman Number
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnConvertIntToRoman(@i AS INT)
RETURNS VARCHAR(30)
BEGIN	
	DECLARE @RomanNumber VARCHAR(30)

	SELECT
		@RomanNumber = 
				REPLICATE('M', @i / 1000) + 
				REPLACE(
					REPLACE(
						REPLACE(
							REPLICATE('C', @i % 1000 / 100),
							REPLICATE('C', 9),
							'CM'
						),
						REPLICATE('C',5),
						'D'
					),
					REPLICATE('C',4),
					'CD'
				) +
				REPLACE(
					REPLACE(
						REPLACE(
							REPLICATE('X', @i % 100 / 10),
							REPLICATE('X', 9),
							'XC'
						),
						REPLICATE('X', 5),
						'L'
					),
					REPLICATE('X', 4),
					'XL'
				) +
				REPLACE(
					REPLACE(
						REPLACE(
							REPLICATE('I', @i % 10),
							REPLICATE('I', 9),
							'IX'
						),
						REPLICATE('I', 5),
						'V'
					),
					REPLICATE('I', 4),
					'IV'
				)

	RETURN @RomanNumber
END
GO