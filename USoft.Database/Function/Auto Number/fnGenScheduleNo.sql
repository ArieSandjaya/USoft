 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenScheduleNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenScheduleNo'
	DROP FUNCTION [dbo].[fnGenScheduleNo]
END
GO

PRINT 'CREATE FUNCTION fnGenScheduleNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenScheduleNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Schedule Number
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenScheduleNo()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewID VARCHAR(8)

	SELECT
		@NewID = 
			CONVERT(VARCHAR,YEAR(GETDATE()))
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(MAX(ScheduleNo),0) + 1), 4)
	FROM
		IT_ScheduleTask WITH(NOLOCK)
	WHERE
		ScheduleNo LIKE CONVERT(VARCHAR,YEAR(GETDATE()))+'%'
		
	RETURN @NewID
END
GO 