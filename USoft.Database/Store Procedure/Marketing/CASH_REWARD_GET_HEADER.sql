IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'cash_reward_get')
	BEGIN
		PRINT 'DROP PROCEDURE cash_reward_get'
		DROP PROCEDURE [dbo].[cash_reward_get]
	END

GO
PRINT 'CREATE PROCEDURE cash_reward_get'
GO
----------------------------------------------------------------
/*
**	SP Name			: CASH_REWARD_GET_HEADER
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-07-22
**	Description		: SP untuk Search Data Cash Reward
**
**	Change Log		:
**	No.		Date	Name		Description

*/
-------------------------------------------------------------------



ALTER PROCEDURE [dbo].[CASH_REWARD_GET_HEADER]
@Contract VARCHAR(50)
AS
BEGIN
	SELECT  DISTINCT
			contract_id,
			supplier_type,
			supplier_code,
			brand_code,
			brand_name,
			condition,
			supplier_name,
			branch,
			parent_branch,
			contract_number,
			commence_process_date,
			CustomerName,
			dp_rate,
			contract_term,
			payment_due_type_code,
			flat_input_rate,
			CarType,
			CarTypeName,
			admin_fee,
			Eligible,
			AmountReward
	INTO #myTable
	FROM [172.172.100.7].UGETS.dbo.v_cash_rewards vcr WITH (NOLOCK)
	WHERE contract_number = @Contract
	  

SELECT * INTO #CASH_REWARD from #myTable
SELECT * INTO #myPricing from cash_reward_pricing 
SELECT * INTO #myDealer  from cash_reward_dealer

SELECT A.*,B.Area,B.Amount,use_area INTO #myTable2 from #myTable A
LEFT JOIN #myDealer B ON (A.brand_code = B.brand_code AND A.supplier_code = B.dealer_code)


SELECT * INTO #myTable3 FROM 
(SELECT * ,
		(SELECT 'Y' FROM #myPricing WHERE Type = CarType AND Brand_code = #myTable2.brand_code
									AND Tenor = contract_term AND adminfee = admin_fee
									AND FLAT_INPUT_ADDM = flat_input_rate AND USE_AREA = #myTable2.use_area
									AND AREA = #myTable2.AREA) AS ELIG
FROM #myTable2 WHERE payment_due_type_Code = 'IN_ADV_PDT' 

UNION ALL

SELECT * ,
		(SELECT 'Y' FROM #myPricing WHERE Type = CarType AND Brand_code = #myTable2.brand_code
									AND Tenor = contract_term AND adminfee = admin_fee
									AND FLAT_INPUT_ADDB = flat_input_rate AND USE_AREA = #myTable2.use_area
									AND AREA = #myTable2.AREA) AS ELIG
FROM #myTable2 WHERE payment_due_type_Code = 'IN_ARR_PDT') AS XX



UPDATE #CASH_REWARD SET ELIGIBLE = ISNULL(#myTable3.ELIG,'N'),AMOUNTREWARD = ISNULL(#myTable3.AMOUNT,0)
FROM #myTable3
WHERE  #CASH_REWARD.CONTRACT_ID = #myTable3.CONTRACT_ID AND #CASH_REWARD.SUPPLIER_TYPE = #myTable3.SUPPLIER_TYPE
AND #CASH_REWARD.SUPPLIER_CODE = #myTable3.SUPPLIER_CODE

SELECT CONTRACT_ID,CONTRACT_NUMBER,CUSTOMERNAME,SUPPLIER_NAME,PARENT_BRANCH BRANCH,BRAND_NAME,CARTYPENAME,ELIGIBLE FROM #CASH_REWARD

END

GO

/*
GRANT EXEC ON Stored_Procedure_Name TO PUBLIC

GO
*/

