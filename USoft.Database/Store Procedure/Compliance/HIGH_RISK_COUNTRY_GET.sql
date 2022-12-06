IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'HIGH_RISK_COUNTRY_GET')
	BEGIN
		PRINT 'DROP PROCEDURE HIGH_RISK_COUNTRY_GET'
		DROP PROCEDURE [dbo].[cash_reward_get]
	END

GO
PRINT 'CREATE PROCEDURE HIGH_RISK_COUNTRY_GET'
GO
----------------------------------------------------------------
/*
**	SP Name			: HIGH_RISK_COUNTRY_GET
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-08-12
**	Description		: SP untuk Search High Risk Country
**
**	Change Log		:
**	No.		Date	Name		Description

*/
-------------------------------------------------------------------



ALTER PROCEDURE HIGH_RISK_COUNTRY_GET
	@countryName VARCHAR(200),
	@piintPageNo INT,
	@piintPageSize INT,
	@pointTotalPage INT OUTPUT,
	@pointTotalData INT OUTPUT
AS
BEGIN

DECLARE @rowcount int
DECLARE @firstid decimal(29,0)

	SELECT @rowcount = ((@piintPageNo * @piintPageSize) - @piintPageSize) + 1

SET ROWCOUNT @rowcount 


SELECT @pointTotalData = COUNT(ID) FROM [HIGH_RISK_COUNTRY]WITH (NOLOCK) WHERE COUNTRY_NAME LIKE '%'+ @countryName +'%'
SELECT @firstid = ID FROM [HIGH_RISK_COUNTRY]WITH (NOLOCK) WHERE COUNTRY_NAME LIKE '%'+ @countryName +'%' ORDER BY ID

	SET @pointTotalPage = @pointTotalData / @piintPageSize

	SET ROWCOUNT @piintPageSize



SELECT [ID]
      ,[COUNTRY_NAME]
      ,[DELETE_FLAG]
      ,[CREATE_BY]
      ,[CREATE_DATE]
      ,[UPDATE_BY]
      ,[UPDATE_DATE]
  FROM [USOFT_DEMO].[dbo].[HIGH_RISK_COUNTRY]
  WHERE [ID] >= @firstid AND COUNTRY_NAME LIKE '%'+ @countryName +'%'
  ORDER BY ID
END

GO

/*
GRANT EXEC ON Stored_Procedure_Name TO PUBLIC

GO
*/

