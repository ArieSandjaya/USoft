BEGIN TRAN ScriptOperation
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenActivityNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenActivityNo'
	DROP FUNCTION [dbo].[fnGenActivityNo]
END
GO

PRINT 'CREATE FUNCTION fnGenActivityNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenActivityNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Activity Number
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenActivityNo()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewID VARCHAR(10)

	SELECT
		@NewID = 
			CONVERT(VARCHAR,YEAR(GETDATE()))
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(MAX(ActivityNo),0) + 1), 4)
	FROM
		IT_ActivityTask WITH(NOLOCK)
	WHERE
		ActivityNo LIKE CONVERT(VARCHAR,YEAR(GETDATE()))+'%'
		
	RETURN @NewID
END
GO 

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemCode'
	DROP FUNCTION [dbo].[fnGenItemCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-05-31
**	Description		: Function untuk generate Item Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			'IT'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemCode),4),0) + 1), 4)
	FROM
		IT_Item WITH (NOLOCK)
	WHERE
		ITItemCode LIKE ('IT' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemInCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemInCode'
	DROP FUNCTION [dbo].[fnGenItemInCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemInCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemInCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Item-In Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemInCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'I'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemInCode),3),0) + 1), 3)
	FROM
		IT_ItemIn WITH (NOLOCK)
	WHERE
		ITItemInCode LIKE ('I' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO 

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemInDetailCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemInDetailCode'
	DROP FUNCTION [dbo].[fnGenItemInDetailCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemInDetailCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemInDetailCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-30
**	Description		: Function untuk generate Item-In Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemInDetailCode(@ITItemInCode varchar(8))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			@ITItemInCode
			+
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemInDtlCode),2),0) + 1), 2)
	FROM
		IT_ItemInDtl WITH (NOLOCK)
	WHERE
		ITItemInDtlCode LIKE (@ITItemInCode + '%')
		
	RETURN @NewCode
END
GO  

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemOutCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemOutCode'
	DROP FUNCTION [dbo].[fnGenItemOutCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemOutCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemOutCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-13
**	Description		: Function untuk generate Item-Out Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemOutCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'O'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemOutCode),3),0) + 1), 3)
	FROM
		IT_ItemOut WITH (NOLOCK)
	WHERE
		ITItemOutCode LIKE ('O' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemTransCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemTransCode'
	DROP FUNCTION [dbo].[fnGenItemTransCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemTransCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemTransCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-07
**	Description		: Function untuk generate Item Trans Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemTransCode()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(8)

	SELECT
		@NewCode = 
			'T'
			+
			CONVERT(VARCHAR(4),GETDATE(),12)
			+
			RIGHT('000' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemTransCode),3),0) + 1), 3)
	FROM
		IT_ItemTrans WITH (NOLOCK)
	WHERE
		ITItemTransCode LIKE ('T' + convert(varchar(4),getdate(),12) + '%')
		
	RETURN @NewCode
END
GO  

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenItemTransDetailCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenItemTransDetailCode'
	DROP FUNCTION [dbo].[fnGenItemTransDetailCode]
END
GO

PRINT 'CREATE FUNCTION fnGenItemTransDetailCode'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenItemTransDetailCode
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-10
**	Description		: Function untuk generate Item Transfer Detail Code
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenItemTransDetailCode(@ITItemTransCode varchar(8))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewCode VARCHAR(10)

	SELECT
		@NewCode = 
			@ITItemTransCode
			+
			RIGHT('00' + CONVERT(VARCHAR,ISNULL(RIGHT(MAX(ITItemTransDtlCode),2),0) + 1), 2)
	FROM
		IT_ItemTransDtl WITH (NOLOCK)
	WHERE
		ITItemTransDtlCode LIKE (@ITItemTransCode + '%')
		
	RETURN @NewCode
END
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGenPurchaseNo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION fnGenPurchaseNo'
	DROP FUNCTION [dbo].[fnGenPurchaseNo]
END
GO

PRINT 'CREATE FUNCTION fnGenPurchaseNo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: fnGenPurchaseNo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: Function untuk generate Purchase Order ID
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE FUNCTION fnGenPurchaseNo()
RETURNS VARCHAR(20)
BEGIN
	DECLARE @NewID VARCHAR(10)

	SELECT
		@NewID = 
			CONVERT(VARCHAR(6),GETDATE(),112)
			+
			RIGHT('0000' + CONVERT(VARCHAR,ISNULL(MAX(order_id),0) + 1), 4)
	FROM
		GA_PORequest WITH(NOLOCK)
	WHERE
		order_id LIKE CONVERT(VARCHAR(6),GETDATE(),112)+'%'
		
	RETURN @NewID
END
GO

--**
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

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetApprovalState]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetApprovalState'
	DROP PROCEDURE [dbo].[spGetApprovalState]
END
GO

PRINT 'CREATE PROCEDURE spGetApprovalState'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetApprovalState
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Page Approval
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetApprovalState
	@piintMenuId INT,
	@piintState INT,
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ApprovalState = convert(bit,1)
	FROM (
		SELECT
			*
		FROM
			MsMappingApproval WITH(NOLOCK)
		WHERE
			IsActive = 1
			AND MenuId = @piintMenuId
			AND State = @piintState
			AND UserIdApproval = @pivchUserId

		UNION

		SELECT
			a.*
		FROM
			MsMappingApproval AS a WITH(NOLOCK)
			INNER JOIN MsUsers AS b WITH(NOLOCK) ON
				a.ParentCode = b.PrivilegeCode
		WHERE
			a.IsActive = 1
			AND a.MenuId = @piintMenuId
			AND a.State = @piintState
			AND a.UserIdApproval IS NULL
		) AS Qry
		INNER JOIN MsUsers AS Usr WITH(NOLOCK) ON
			Qry.UserIdApproval = Usr.UserId
	WHERE
		ISNULL(Qry.BranchId,Usr.BranchId) = Usr.BranchId
END
GO

SET NOCOUNT OFF
GO          

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranch]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranch'
	DROP PROCEDURE [dbo].[spGetBranch]
END
GO

PRINT 'CREATE PROCEDURE spGetBranch'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranch / MsGetBranch
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Branch
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranch
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		*
	FROM
		MsBranch WITH(NOLOCK)
	WHERE
		IsActive = 1
		AND BranchType = 1
END
GO

SET NOCOUNT OFF
GO          

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranchDomainToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranchDomainToCombo'
	DROP PROCEDURE [dbo].[spGetBranchDomainToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetBranchDomainToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranchDomainToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Branch Domain To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranchDomainToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			Branch_Code,
			Branch_Name
		FROM
			IT_DomainServer WITH(NOLOCK)
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetBranchToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetBranchToCombo'
	DROP PROCEDURE [dbo].[spGetBranchToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetBranchToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetBranchToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Branch To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetBranchToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			BranchId,
			BranchName
		FROM
			MsBranch WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetConditionToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetConditionToCombo'
	DROP PROCEDURE [dbo].[spGetConditionToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetConditionToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetConditionToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-30
**	Description		: SP untuk Bind Data Condition To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetConditionToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ConditionCode,
			ConditionName
		FROM
			MsCondition WITH(NOLOCK)
		WHERE
			IsActive = 1
		'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCurrencyToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetCurrencyToCombo'
	DROP PROCEDURE [dbo].[spGetCurrencyToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetCurrencyToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetCurrencyToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Currency To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetCurrencyToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			currency_code,
			currency_code
		FROM
			MsCurrency
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetDepartementToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetDepartementToCombo'
	DROP PROCEDURE [dbo].[spGetDepartementToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetDepartementToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetDepartementToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Departement To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetDepartementToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			DepartementCode,
			DepartementName
		FROM
			MsDepartement WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetItemGroupToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetItemGroupToCombo'
	DROP PROCEDURE [dbo].[spGetItemGroupToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetItemGroupToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetItemGroupToCombo / MsGetBranch
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Item Group
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetItemGroupToCombo
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			item_group_code,
			item_group_name
		FROM
			MsItemGroup WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetItemTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetItemTypeToCombo'
	DROP PROCEDURE [dbo].[spGetItemTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetItemTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetItemTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Item Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetItemTypeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			item_type_code,
			item_type_name
		FROM
			MsItemType WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemByBranchTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemByBranchTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemByBranchTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemByBranchTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemByBranchTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Bind Data Item by Branch and Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemByBranchTypeToCombo
	@piintBranchId INT,
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@pivchItemTypeCode <> '') -- Harus dipilih kedua nya
	BEGIN	
		SELECT
			ITItemCode,
			ITItemCode + ' - ' + SerialNo + ' - ' + Description AS ItemName
		FROM
			IT_Item WITH(NOLOCK)
		WHERE
			IsActive = 1 -- Is not dispose
			AND ITItemOutCode IS NULL	-- Is not in repair condition
			AND item_type_code = @pivchItemTypeCode
			AND ISNULL(BranchId,0) = @piintBranchId
	END
END
GO 

--**
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetITItemTransByBranchTypeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetITItemTransByBranchTypeToCombo'
	DROP PROCEDURE [dbo].[spGetITItemTransByBranchTypeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetITItemTransByBranchTypeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetITItemTransByBranchTypeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Bind Data Item by Branch and Type To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetITItemTransByBranchTypeToCombo
	@pivchITItemTransCode VARCHAR(8),
	@pivchItemTypeCode VARCHAR(10),
	@pivchITItemCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemCode,
		a.SerialNo + ' - ' + a.Description AS ItemName
	FROM
		IT_Item AS a WITH(NOLOCK)
		INNER JOIN IT_ItemTrans AS b WITH(NOLOCK) ON
			ISNULL(a.BranchId,0) = ISNULL(b.BranchId_From,0)
	WHERE
		a.IsActive = 1 -- Dispose State
		AND a.ITItemOutCode IS NULL	-- Repair State
		AND b.ITItemTransCode = @pivchITItemTransCode
		AND a.item_type_code = @pivchItemTypeCode
		AND a.ITItemCode NOT IN (
			SELECT
				ITItemCode
			FROM
				IT_ItemTransDtl WITH(NOLOCK)
			WHERE
				ITItemTransCode = @pivchITItemTransCode
				AND (
					@pivchITItemCode IS NULL
					OR
					ITItemCode <> @pivchITItemCode
				)
		)
END
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingApprovalEmailCC]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingApprovalEmailCC'
	DROP PROCEDURE [dbo].[spGetMappingApprovalEmailCC]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingApprovalEmailCC'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingApprovalEmailCC
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Mapping Approval Email CC
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingApprovalEmailCC
	@piintMenuId INT,
	@piintState INT
AS
BEGIN
	SET NOCOUNT ON
	
	-- Get User Approval by Email
	SELECT
		c.UserName,
		c.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsMappingApprovalMail AS b WITH(NOLOCK) ON 
			a.ApprovalID = b.ApprovalID
		INNER JOIN MsUsers AS c WITH(NOLOCK) ON
			b.UserEmail = c.UserId
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND c.IsActive = 1
END
GO

SET NOCOUNT OFF
GO           

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingApprovalEmailTo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingApprovalEmailTo'
	DROP PROCEDURE [dbo].[spGetMappingApprovalEmailTo]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingApprovalEmailTo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingApprovalEmailTo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Mapping Approval Email To
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingApprovalEmailTo
	@piintMenuId INT,
	@piintState INT
AS
BEGIN
	SET NOCOUNT ON
	
	-- Get User Approval by User ID
	SELECT
		b.UserName,
		b.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.UserIdApproval = b.UserId
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND b.IsActive = 1

	UNION

	-- Get User Approval by Privilege
	SELECT
		b.UserName,
		b.Email
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.ParentCode = b.PrivilegeCode
	WHERE
		a.MenuId = @piintMenuId
		AND a.State = @piintState
		AND a.IsActive = 1
		AND b.IsActive = 1
		AND a.UserIdApproval IS NULL
END
GO

SET NOCOUNT OFF
GO          

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMappingUsersToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMappingUsersToCombo'
	DROP PROCEDURE [dbo].[spGetMappingUsersToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetMappingUsersToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMappingUsersToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Mapping User To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMappingUsersToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			a.UserId,
			b.UserName
		FROM
			MsMappingUsers AS a WITH(NOLOCK)
			INNER JOIN MsUsers AS b WITH(NOLOCK) ON
				a.UserId = b.UserId
		WHERE
			a.IsActive = 1
			AND b.IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMeasurementToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMeasurementToCombo'
	DROP PROCEDURE [dbo].[spGetMeasurementToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetMeasurementToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMeasurementToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Item To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMeasurementToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			measurement_code,
			measurement_code
		FROM
			MsMeasurement
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMenuPrivilegeAll]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMenuPrivilegeAll'
	DROP PROCEDURE [dbo].[spGetMenuPrivilegeAll]
END
GO

PRINT 'CREATE PROCEDURE spGetMenuPrivilegeAll'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMenuPrivilegeAll / MsMenuPrivGetAll
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Menu Tree Privilege
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMenuPrivilegeAll
	@PrivCode VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON
	
	IF OBJECT_ID('tempdb..#tblmenus') IS NOT NULL
	BEGIN
		DROP TABLE #tblmenus
	END
	ELSE
	BEGIN
		CREATE TABLE #tblmenus(MenuId int,
							   MenuName varchar(50),
							   MenuParent int,
							   MenuLink varchar(100),
							   ReportId varchar(50),
							   InsertDt bit,
							   UpdateDt bit,
							   DeleteDt bit,
							   ViewDt bit)
	END
		
	INSERT INTO #tblmenus(
		MenuId,
		MenuName,
		MenuParent,
		MenuLink,
		ReportId
	)
	SELECT
		MenuId,
		MenuName,
		MenuParent,
	    MenuLink,
	    ReportId
	FROM
		MsMenu WITH (NOLOCK)
	ORDER BY
		MenuId
		
	UPDATE
		#tblmenus
	SET
		-- Replace by dwi 20130607
		/*
		InsertDt = MsPriveledgeDt.InsertDt,
		UpdateDt = MsPriveledgeDt.UpdateDt,
		DeleteDt = MsPriveledgeDt.DeleteDt,
		ViewDt = MsPriveledgeDt.ViewDt
		*/
		InsertDt = MsPrivilegeDt.InsertDt,
		UpdateDt = MsPrivilegeDt.UpdateDt,
		DeleteDt = MsPrivilegeDt.DeleteDt,
		ViewDt = MsPrivilegeDt.ViewDt
	FROM
		--MsPriveledgeDt
		MsPrivilegeDt
	WHERE
		--#tblmenus.MenuId = MsPriveledgeDt.MenuId
		--AND MsPriveledgeDt.PriveledgeCode = @PrivCode
		#tblmenus.MenuId = MsPrivilegeDt.MenuId
		AND MsPrivilegeDt.PrivilegeCode = @PrivCode

	SELECT
		MenuId,
		MenuName,
		MenuParent,
		MenuLink,
		ReportId,
		CASE WHEN ISNULL(InsertDt,0) = 0 THEN 'false' ELSE 'true' END InsertDt,
		CASE WHEN ISNULL(UpdateDt,0) = 0 THEN 'false' ELSE 'true' END UpdateDt,
		CASE WHEN ISNULL(DeleteDt,0) = 0 THEN 'false' ELSE 'true' END DeleteDt,
		CASE WHEN ISNULL(ViewDt,0) = 0 THEN 'false' ELSE 'true' END ViewDt
	FROM
		#tblmenus
END
GO

SET NOCOUNT OFF
GO

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMenuToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMenuToCombo'
	DROP PROCEDURE [dbo].[spGetMenuToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetMenuToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMenuToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Menu To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMenuToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			MenuId,
			MenuName
		FROM
			MsMenu WITH(NOLOCK)
		WHERE
			MenuActive = ''Y''
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetMenuUsers]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetMenuUsers'
	DROP PROCEDURE [dbo].[spGetMenuUsers]
END
GO

PRINT 'CREATE PROCEDURE spGetMenuUsers'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetMenuUsers / MsMenuViewer
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data Menu Users
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetMenuUsers
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Qry1.UserId,
		Qry1.MenuId,
		Qry2.MenuName,
		Qry2.MenuParent,
		Qry2.MenuLink,
		Qry2.IsActive,
		Qry1.InsertDt,
		Qry1.UpdateDt,
		Qry1.DeleteDt,
		Qry1.ViewDt,
		Qry2.ReportId,
		Qry2.Parameter
	FROM
		(
			SELECT
				UserId,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			FROM
				MsUserMenu WITH(NOLOCK)
			WHERE
				UserId = @pivchUserId

			UNION

			SELECT
				b.UserId,
				a.MenuId,
				a.InsertDt,
				a.UpdateDt,
				a.DeleteDt,
				a.ViewDt
			FROM
				MsPrivilegeDt AS a WITH(NOLOCK)
				INNER JOIN MsUsers AS b WITH(NOLOCK) ON
					a.PrivilegeCode = b.PrivilegeCode
			WHERE
				b.UserId = @pivchUserId
				AND a.MenuId NOT IN (
					select
						MenuId
					from
						MsUserMenu
					where
						UserId = @pivchUserId
				)
		) AS Qry1
		INNER JOIN MsMenu AS Qry2 WITH (nolock) ON
			Qry1.MenuId = Qry2.MenuId
		INNER JOIN MsUsers AS Qry3 WITH (NOLOCK) ON 
			Qry1.UserId = Qry3.UserId
	WHERE
		Qry3.IsActive = 1
		AND Qry2.IsActive = 1
	ORDER BY
		Qry1.MenuId

	/* Previous Version 20130607 dwi
	SELECT
		a.UserId,
		a.MenuId,
		b.MenuName,
		b.MenuParent,
		b.MenuLink,
		b.IsActive,
		a.InsertDt,
		a.UpdateDt,
		a.DeleteDt,
		a.ViewDt,
		b.ReportId,
		b.Parameter
	FROM
		MsUserMenu AS a WITH (nolock)
		INNER JOIN MsMenu AS b WITH (nolock) ON
			a.MenuId = b.MenuId
		INNER JOIN MsUsers AS c WITH (NOLOCK) ON 
			a.UserId = c.UserId
	WHERE
		c.Active = 1
		AND b.IsActive = 1
		AND a.UserId = @pivchUserId
	ORDER BY
		a.MenuId
	*/
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetParamFieldToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetParamFieldToCombo'
	DROP PROCEDURE [dbo].[spGetParamFieldToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetParamFieldToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetParamFieldToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Field Search To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetParamFieldToCombo		
	@pivchMenuID VARCHAR(6)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			ParamName,
			ParamType + ''|'' + ParamField AS ParamField
		FROM
			MsMenuSearch WITH(NOLOCK)
		WHERE
			IsActive = 1
			AND MenuID = ''' + @pivchMenuID + '''
		ORDER BY
			SequenceNo
	'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetPrivilegeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetPrivilegeToCombo'
	DROP PROCEDURE [dbo].[spGetPrivilegeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetPrivilegeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetPrivilegeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Privilege To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetPrivilegeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			PrivilegeCode,
			PrivilegeName
		FROM
			MsPrivilege WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetSupplierToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetSupplierToCombo'
	DROP PROCEDURE [dbo].[spGetSupplierToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetSupplierToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetSupplierToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Supplier To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetSupplierToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			supplier_id,
			supplier_name
		FROM
			MsSupplier
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserByPrivilegeToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserByPrivilegeToCombo'
	DROP PROCEDURE [dbo].[spGetUserByPrivilegeToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetUserByPrivilegeToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserByPrivilegeToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data Branch To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserByPrivilegeToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			UserId,
			UserName
		FROM
			MsUsers WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO      

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserEmail]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserEmail'
	DROP PROCEDURE [dbo].[spGetUserEmail]
END
GO

PRINT 'CREATE PROCEDURE spGetUserEmail'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserEmail
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User Email
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserEmail
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserName,
		Email
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		IsActive = 1
		AND UserId = @pivchUserId
END
GO

SET NOCOUNT OFF
GO         

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserId]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserId'
	DROP PROCEDURE [dbo].[spGetUserId]
END
GO

PRINT 'CREATE PROCEDURE spGetUserId'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserId / MsGetUserid
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User ID
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserId
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		UserName,
		PriviledgeCode
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		IsActive = 1
END
GO

SET NOCOUNT OFF
GO         

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserLogon]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserLogon'
	DROP PROCEDURE [dbo].[spGetUserLogon]
END
GO

PRINT 'CREATE PROCEDURE spGetUserLogon'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserLogon / MsUserLogon
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Data User Logon
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserLogon		
	@UserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		Pass,
		UserName,
		BranchId,
		Email,
		ChangePass,
		--PriviledgeCode
		PrivilegeCode
	FROM
		MsUsers WITH (NOLOCK)
	WHERE
		UserId = @UserId
		AND IsActive = 1
END
GO

SET NOCOUNT OFF
GO        

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetUserToCombo]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGetUserToCombo'
	DROP PROCEDURE [dbo].[spGetUserToCombo]
END
GO

PRINT 'CREATE PROCEDURE spGetUserToCombo'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGetUserToCombo
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Bind Data User To Combo
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGetUserToCombo		
	@pivchWhere VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = '
		SELECT
			UserId,
			UserName
		FROM
			MsUsers WITH(NOLOCK)
		WHERE
			IsActive = 1
	'
	
	IF (@pivchWhere <> '')
		SET @sql = @sql + ' AND ' + @pivchWhere
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO       


--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseDetailDelete'
	DROP PROCEDURE [dbo].[spPurchaseDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Purchase Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseDetailDelete
	@pivchOrderID VARCHAR(20),
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
				
		DELETE FROM
			GA_PORequestDetail
		WHERE
			order_id = @pivchOrderID
			AND item_type_code = @pivchItemTypeCode
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
		SELECT
			@TotalPrice = SUM(quantity*price)
		FROM
			GA_PORequestDetail WITH(NOLOCK)
		WHERE
			order_id = @pivchOrderID
		
		UPDATE
			GA_PORequest
		SET
			Total = @TotalPrice
		WHERE
			order_id = @pivchOrderID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseDetailInsertUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseDetailInsertUpdate'
	DROP PROCEDURE [dbo].[spPurchaseDetailInsertUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseDetailInsertUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseDetailInsertUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseDetailInsertUpdate
	@pivchOrderID VARCHAR(20),
	@pivchItemTypeCode VARCHAR(10),
	@pidblQuantity FLOAT,
	@pivchMeasurementCode VARCHAR(10),
	@pimonPrice MONEY,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseDetailInsertUpdate
		DECLARE
			@ErrMsg VARCHAR(2000),
			@TotalPrice MONEY
				
		-- Update If Already Insert Before
		UPDATE
			GA_PORequestDetail
		SET
			quantity = @pidblQuantity,
			price = @pimonPrice,
			total = @pidblQuantity * @pimonPrice,
			created_date = GETDATE(),
			created_by = @pivchInputID
		WHERE
			order_id = @pivchOrderID
			AND item_type_code = @pivchItemTypeCode
			AND measurement_code = @pivchMeasurementCode
			
		-- Insert New
		IF @@ROWCOUNT = 0
		BEGIN					
			INSERT INTO GA_PORequestDetail (
				order_id,
				item_type_code,
				quantity,
				measurement_code,
				price,
				total,
				created_date,
				created_by
			)
			SELECT
				@pivchOrderID,
				@pivchItemTypeCode,
				@pidblQuantity,
				@pivchMeasurementCode,
				@pimonPrice,
				@pidblQuantity * @pimonPrice,
				GETDATE(),
				@pivchInputID
		END
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
		SELECT
			@TotalPrice = SUM(quantity*price)
		FROM
			GA_PORequestDetail WITH(NOLOCK)
		WHERE
			order_id = @pivchOrderID
		
		UPDATE
			GA_PORequest
		SET
			Total = @TotalPrice
		WHERE
			order_id = @pivchOrderID
		
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN PurchaseDetailInsertUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseDetailInsertUpdate
	END
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseDetailList'
	DROP PROCEDURE [dbo].[spPurchaseDetailList]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Purchase Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseDetailList		
	@pivchOrderID VARCHAR(20),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.*,
					b.item_type_name,
					c.description AS desc_measurement
				FROM
					GA_PORequestDetail AS a WITH(NOLOCK)
					INNER JOIN MsItemType AS b WITH(NOLOCK) ON (a.item_type_code = b.item_type_code)
					INNER JOIN MsMeasurement AS c WITH(NOLOCK) ON (a.measurement_code = c.measurement_code)
				WHERE
					a.order_id = ''' + @pivchOrderID + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseDetailView'
	DROP PROCEDURE [dbo].[spPurchaseDetailView]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Purchase Detail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseDetailView		
	@pivchOrderID VARCHAR(20),
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		order_id,
		item_type_code,
		quantity,
		measurement_code,
		price,
		total
	FROM
		GA_PORequestDetail WITH(NOLOCK)
	WHERE
		order_id = @pivchOrderID
		AND item_type_code = @pivchItemTypeCode
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseInsert'
	DROP PROCEDURE [dbo].[spPurchaseInsert]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Purchase Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseInsert
	@pidtmOrderDate DATETIME,
	@pichrType CHAR,
	@pivchReason TEXT,
	@pivchSupplierID VARCHAR(5),
	@pivchCurrencyCode VARCHAR(3),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseInsert
		DECLARE
			@BranchID INT,
			@ErrMsg VARCHAR(2000)
				
		SELECT @BranchID = BranchID FROM MsUsers WHERE UserId = @pivchInputID
		
		INSERT INTO GA_PORequest (
			order_id,
			order_date,
			type,
			reason,
			supplier_id,
			currency_code,
			status,
			created_date,
			created_by,
			BranchId
		)
		SELECT
			dbo.fnGenPurchaseNo(),
			@pidtmOrderDate,
			@pichrType,
			@pivchReason,
			CASE
				WHEN @pivchSupplierID = '' THEN NULL
				ELSE @pivchSupplierID
			END AS supplier_id,
			@pivchCurrencyCode,
			'D',
			GETDATE(),
			@pivchInputID,
			@BranchID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseInsert
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseInsert
	END
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseList'
	DROP PROCEDURE [dbo].[spPurchaseList]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Purchase Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.order_id,
					a.order_date,
					a.status,
					b.UserName
				FROM
					GA_PORequest AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
					INNER JOIN MsCurrency AS c WITH(NOLOCK) ON (a.currency_code = c.currency_code)'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseUpdate'
	DROP PROCEDURE [dbo].[spPurchaseUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Purchase Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseUpdate
	@pivchOrderID VARCHAR(20),
	@pidtmOrderDate DATETIME,
	@pichrType CHAR,
	@pivchReason TEXT,
	@pivchSupplierID VARCHAR(5),
	@pivchCurrencyCode VARCHAR(3),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseUpdate
		DECLARE
			@BranchID INT,
			@ErrMsg VARCHAR(2000)
				
		UPDATE GA_PORequest
		SET
			order_date = @pidtmOrderDate,
			type = @pichrType,
			reason = @pivchReason,
			supplier_id = CASE
							WHEN @pivchSupplierID = '' THEN NULL
							ELSE @pivchSupplierID
						END,
			currency_code = @pivchCurrencyCode,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			order_id = @pivchOrderID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PurchaseUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseUpdate
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPurchaseView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPurchaseView'
	DROP PROCEDURE [dbo].[spPurchaseView]
END
GO

PRINT 'CREATE PROCEDURE spPurchaseView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPurchaseView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Purchase Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPurchaseView		
	@pivchOrderID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.order_id,
		a.order_date,
		a.type,
		a.reason,
		a.Supplier_Id,
		d.Supplier_Name,
		ISNULL(a.total,0) AS total,
		a.currency_code,
		b.UserName AS Input_Name,
		c.BranchName,
		a.status
	FROM
		GA_PORequest AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON a.created_by = b.UserId
		INNER JOIN MsBranch AS c WITH(NOLOCK) ON b.BranchId = c.BranchId
		LEFT JOIN MsSupplier AS d WITH(NOLOCK) ON a.Supplier_Id = d.Supplier_Id
	WHERE
		a.order_id = @pivchOrderID
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spB2BSendMail]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spB2BSendMail'
	DROP PROCEDURE [dbo].[spB2BSendMail]
END
GO

PRINT 'CREATE PROCEDURE spB2BSendMail'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spB2BSendMail / b2b_sendMail_Raksa / b2b_sendMail_Tokio / b2b_sendMail_Aswata
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show B2B Mail Raksa
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spB2BSendMail		
	@piintBranchId INT,
	@pivchInsType VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Email,
		EmailType,
		EmailSource
	FROM
		B2B_DefaultEmail WITH(NOLOCK)
	WHERE
		DeleteFlag = 'N'
		AND
		EmailSource = @pivchInsType
		
	UNION 
	
	SELECT
		Email,
		'CC' AS EmailType,
		'UFI' AS EmailSource
	FROM
		MsUSers WITH(NOLOCK)
	WHERE
		BranchId = @piintBranchId
		AND
		IsActive = 1
		AND
		CanSendMail = 'Y'
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityAssignInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityAssignInsert'
	DROP PROCEDURE [dbo].[spActivityAssignInsert]
END
GO

PRINT 'CREATE PROCEDURE spActivityAssignInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityAssignInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityAssignInsert
	@pivchActivityNo VARCHAR(12),
    @pivchStatus VARCHAR(1),
    @pivchAssignTo VARCHAR(50),
    @pivchAssignDescription VARCHAR(255),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityAssignInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		INSERT INTO IT_ActivityAssign (
			ActivityNo,
			AssignTo,
			AssignFrom,
			StatusAssign,
			DateAssign,
			Description,
			ReAssignID
		)
		SELECT
			@pivchActivityNo,
			CASE
				WHEN @pivchAssignTo = '' THEN NULL
				ELSE @pivchAssignTo
			END,
			@pivchInputID,
			@pivchStatus,
			GETDATE(),
			@pivchAssignDescription,
			NULL
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
		UPDATE
			IT_ActivityTask
		SET
			Status = @pivchStatus,
			ApprovalState = CASE
								WHEN @pivchStatus IN ('2','3') THEN 2
								WHEN @pivchStatus = '4' THEN 3
								ELSE CONVERT(INT,@pivchStatus)
							END
		WHERE
			ActivityNo = @pivchActivityNo
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityAssignInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityAssignInsert
	END
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityAssignList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityAssignList'
	DROP PROCEDURE [dbo].[spActivityAssignList]
END
GO

PRINT 'CREATE PROCEDURE spActivityAssignList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityAssignList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Assign Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityAssignList
	@pivchActivityNo VARCHAR(12),
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.AssignID,
					a.AssignFrom,
					b.UserName AS FromName,
					a.AssignTo,
					c.UserName AS ToName,
					a.DateAssign,
					a.StatusAssign,
					a.Description,
					a.ReAssignID
				FROM
					IT_ActivityAssign AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.AssignFrom = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.AssignTo = c.UserId
				WHERE
					a.ActivityNo = ''' + @pivchActivityNo + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY a.DateAssign DESC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityTaskDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityTaskDelete'
	DROP PROCEDURE [dbo].[spActivityTaskDelete]
END
GO

PRINT 'CREATE PROCEDURE spActivityTaskDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityTaskDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityTaskDelete
	@pivchActivityNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityTaskDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ActivityTask
		SET
			IsActive = 0
		WHERE
			ActivityNo = @pivchActivityNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityTaskDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskDelete
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityTaskInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityTaskInsert'
	DROP PROCEDURE [dbo].[spActivityTaskInsert]
END
GO

PRINT 'CREATE PROCEDURE spActivityTaskInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityTaskInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityTaskInsert
	@pidtmActivityDate DATETIME,
    @pivchRequestBy VARCHAR(100),
    @piintBranchId INT,
    @pivchDepartementCode VARCHAR(2),
    @pivchItemTypeCode VARCHAR(10),
    @piintQuantity INT,
    @pivchDescription VARCHAR(255),
    @pivchPriority VARCHAR(1),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityTaskInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		INSERT INTO IT_ActivityTask (
			ActivityNo,
			ActivityDate,
			RequestBy,
			BranchId,
			DepartementCode,
			item_type_code,
			Quantity,
			Description,
			IsActive,
			Status,
			Priority,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenActivityNo(),
			@pidtmActivityDate,
			@pivchRequestBy,
			@piintBranchId,
			@pivchDepartementCode,
			@pivchItemTypeCode,
			@piintQuantity,
			@pivchDescription,
			1,
			0,
			@pivchPriority,
			GETDATE(),
			@pivchInputID
		
		IF @@ERROR <> 0
			GOTO ExitSP
		
	COMMIT TRAN ActivityTaskInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityTaskList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityTaskList'
	DROP PROCEDURE [dbo].[spActivityTaskList]
END
GO

PRINT 'CREATE PROCEDURE spActivityTaskList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityTaskList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityTaskList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000)
	
	SET @sql = 'SELECT
					a.ActivityNo,
					a.ActivityDate,
					a.item_type_code,
					a.Quantity,
					a.BranchId,
					a.RequestBy,
					a.DepartementCode,
					a.Description,
					a.IsActive,
					a.Status,
					a.Priority,
					a.created_date,
					a.update_date,
					b.AssignID,
					b.AssignTo,
					b.AssignFrom,
					b.DateAssign,
					b.StatusAssign,
					b.Description,
					c.item_type_name,
					d.BranchName,
					e.DepartementName,
					CASE
						WHEN a.update_by IS NULL THEN f.UserName
						ELSE g.UserName
					END AS LastUpdateBy,
					h.UserName AS AssignToName
				FROM
					IT_ActivityTask AS a WITH(NOLOCK)
					LEFT JOIN (
						SELECT
							x.*
						FROM
							IT_ActivityAssign AS x WITH(NOLOCK)
							INNER JOIN (
								SELECT
									ActivityNo,
									MAX(DateAssign) AS DateAssign
								FROM
									IT_ActivityAssign WITH(NOLOCK)
								GROUP BY
									ActivityNo
							) AS y ON
								x.ActivityNo = y.ActivityNo
								AND x.DateAssign = y.DateAssign
					) AS b ON
						a.ActivityNo = b.ActivityNo

					INNER JOIN MsItemType AS c WITH(NOLOCK) ON
						a.item_type_code = c.item_type_code
					INNER JOIN MsBranch AS d WITH(NOLOCK) ON
						a.BranchId = d.BranchId
					LEFT JOIN MsDepartement AS e WITH(NOLOCK) ON
						a.DepartementCode = e.DepartementCode

					-- Last Update
					INNER JOIN MsUsers AS f WITH(NOLOCK) ON
						a.created_by = f.UserId
					LEFT JOIN MsUsers AS g WITH(NOLOCK) ON
						a.update_by = g.UserId

					-- Assign To
					LEFT JOIN MsUsers AS h WITH(NOLOCK) ON
						b.AssignTo = h.UserId
				WHERE
					a.IsActive = 1'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY a.ActivityNo DESC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityTaskUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityTaskUpdate'
	DROP PROCEDURE [dbo].[spActivityTaskUpdate]
END
GO

PRINT 'CREATE PROCEDURE spActivityTaskUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityTaskUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityTaskUpdate
	@pivchActivityNo VARCHAR(12),
	@pidtmActivityDate DATETIME,
    @pivchRequestBy VARCHAR(100),
    @piintBranchId INT,
    @pivchDepartementCode VARCHAR(2),
    @pivchItemTypeCode VARCHAR(10),
    @piintQuantity INT,
    @pivchDescription VARCHAR(255),
    @pivchPriority VARCHAR(1),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ActivityTaskUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_ActivityTask
		SET
			ActivityDate = @pidtmActivityDate,
			RequestBy = @pivchRequestBy,
			BranchId = @piintBranchId,
			DepartementCode = @pivchDepartementCode,
			item_type_code = @pivchItemTypeCode,
			Quantity = @piintQuantity,
			Description = @pivchDescription,
			Priority = @pivchPriority,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ActivityNo = @pivchActivityNo
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ActivityTaskUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ActivityTaskUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spActivityTaskView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spActivityTaskView'
	DROP PROCEDURE [dbo].[spActivityTaskView]
END
GO

PRINT 'CREATE PROCEDURE spActivityTaskView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spActivityTaskView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spActivityTaskView		
	@pivchActivityNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ActivityNo,
		a.ActivityDate,
		a.item_type_code,
		b.item_type_name,
		a.Quantity,
		a.BranchId,
		c.BranchName,
		a.RequestBy,
		a.DepartementCode,
		d.DepartementName,
		a.Description,
		a.Status,
		a.Priority,
		a.IsActive,
		a.ApprovalState
	FROM
		IT_ActivityTask AS a WITH(NOLOCK)
		INNER JOIN MsItemType AS b WITH(NOLOCK) ON
			a.item_type_code = b.item_type_code
		INNER JOIN MsBranch AS c WITH(NOLOCK) ON
			a.BranchId = c.BranchId
		LEFT JOIN MsDepartement AS d WITH(NOLOCK) ON
			a.DepartementCode = d.DepartementCode
	WHERE
		a.ActivityNo = @pivchActivityNo
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainInsert'
	DROP PROCEDURE [dbo].[spBranchDomainInsert]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Branch Domain Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainInsert]
	@pivchBranchCode VARCHAR(5),
	@pivchBranchName VARCHAR(100),
	@pivchBranchIP VARCHAR(15),
	@pivchUserName VARCHAR(50),
	@pivchPassword VARCHAR(100),
	@pivchInputID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchDomainInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_DomainServer WITH(NOLOCK) WHERE Branch_Code = @pivchBranchCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO IT_DomainServer (
				Branch_Code,
				Branch_Name,
				Branch_IP,
				UserName,
				Password,
				created_date,
				created_by
			)
			SELECT
				@pivchBranchCode,
				@pivchBranchName,
				@pivchBranchIP,
				@pivchUserName,
				@pivchPassword,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN BranchDomainInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchDomainInsert
	END
END

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainUpdate'
	DROP PROCEDURE [dbo].[spBranchDomainUpdate]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Branch Domain Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainUpdate]
	@pivchBranchCodeOld VARCHAR(5),
	@pivchBranchCode VARCHAR(5),
	@pivchBranchName VARCHAR(100),
	@pivchBranchIP VARCHAR(15),
	@pivchUserName VARCHAR(50),
	@pivchPassword VARCHAR(100),
	@pivchInputID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchDomainUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM IT_DomainServer WITH(NOLOCK)
				WHERE Branch_Code = @pivchBranchCode AND Branch_Code <> @pivchBranchCodeOld
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			UPDATE IT_DomainServer
			SET
				Branch_Code = @pivchBranchCode,
				Branch_Name = @pivchBranchName,
				Branch_IP = @pivchBranchIP,
				UserName = @pivchUserName,
				update_date = GETDATE(),
				update_by = @pivchInputID
			WHERE
				Branch_Code = @pivchBranchCodeOld
		
			IF @@ERROR <> 0
				GOTO ExitSP
				
			IF (@pivchPassword <> '')
			BEGIN
				UPDATE IT_DomainServer
				SET
					Password = @pivchPassword
				WHERE
					Branch_Code = @pivchBranchCode
			END
		END
			
	COMMIT TRAN BranchDomainUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchDomainUpdate
	END
END

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchDomainView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchDomainView'
	DROP PROCEDURE [dbo].[spBranchDomainView]
END
GO

PRINT 'CREATE PROCEDURE spBranchDomainView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchDomainView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Branch Domain Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spBranchDomainView]		
	@pivchBranchCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Branch_Code,
		Branch_Name,
		Branch_IP,
		UserName,
		Password
	FROM
		IT_DomainServer WITH(NOLOCK)
	WHERE
		Branch_Code = @pivchBranchCode
END

SET NOCOUNT OFF
GO   

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemHistory]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemHistory'
	DROP PROCEDURE [dbo].[spITItemHistory]
END
GO

PRINT 'CREATE PROCEDURE spITItemHistory'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemHistory
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show data Item Detail History
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemHistory		
	@pivchItemCode VARCHAR(10)
	
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ITItemCode,
					a.ITItemInDtlCode,
					b.item_type_name,
					a.SerialNo,
					a.Barcode,
					c.ConditionName,
					d.BranchName,
					a.UsedBy,
					e.PrivilegeName,
					a.update_date
					
				FROM
					IT_Item_History AS a WITH(NOLOCK)
					INNER JOIN MsItemType AS b WITH(NOLOCK) ON (a.item_type_code = b.item_type_code)
					INNER JOIN MsCondition AS c WITH(NOLOCK) ON (a.ConditionCode = c.ConditionCode)
					LEFT JOIN MsBranch d WITH(NOLOCK)  ON a.BranchId = d.BranchId
					LEFT JOIN MsPrivilege e WITH(NOLOCK)  ON a.PrivilegeCode = e.PrivilegeCode
				WHERE
					a.ITItemCode = ''' + @pivchItemCode + '''  
					
				ORDER BY a.update_date DESC'
	
	
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   


--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailDelete'
	DROP PROCEDURE [dbo].[spITItemInDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Delete data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailDelete
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemInDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM
			IT_ItemInDtl
		WHERE
			ITItemInDtlCode = @pivchItemInDetailCode
			AND ITItemInCode = @pivchItemInCode
		
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITItemInDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemInDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailInsert'
	DROP PROCEDURE [dbo].[spITItemInDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-05-30
**	Description		: SP untuk Insert data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailInsert
	@pivchItemInCode VARCHAR(8),
	@pivchItemTypeCode VARCHAR(10),
	@pivchSerialNo VARCHAR(50),
	@pivchBarcode VARCHAR(50),
	@pivchDescription VARCHAR(255),
	@pivchConditionCode INT,
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
		
		IF(
			EXISTS(
				SELECT ''
				FROM IT_Item WITH(NOLOCK)
				WHERE
					IsActive = 1
					AND item_type_code = @pivchItemTypeCode
					AND (
						SerialNo = @pivchSerialNo
						OR
						Barcode = @pivchBarcode
					)
			)
		)
		BEGIN
			SET @ErrMsg = 'Item with SerialNo '+@pivchSerialNo+ ' or Barcode ' +@pivchBarcode+ ' is already in database.'
			GOTO ExitSP
		END
		
		
		INSERT INTO IT_ItemInDtl (
			ITItemInDtlCode,
			ITItemInCode,
			item_type_code,
			SerialNo,
			Barcode,
			Description,
			ConditionCode,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemInDetailCode(@pivchItemInCode),
			@pivchItemInCode,
			@pivchItemTypeCode,
			@pivchSerialNo,
			@pivchBarcode,
			@pivchDescription,
			@pivchConditionCode,
			GETDATE(),
			@pivchInputBy
			
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInDetailInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailList'
	DROP PROCEDURE [dbo].[spITItemInDetailList]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-30
**	Description		: SP untuk show data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailList		
	@pivchWhereBy VARCHAR(1000),
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.*,
					b.item_type_name,
					c.ConditionName
					
				FROM
					IT_ItemInDtl AS a WITH(NOLOCK)
					INNER JOIN MsItemType AS b WITH(NOLOCK) ON (a.item_type_code = b.item_type_code)
					INNER JOIN MsCondition AS c WITH(NOLOCK) ON (a.ConditionCode = c.ConditionCode)
				WHERE
					a.ITItemInCode = ''' + @pivchItemInCode + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailUpdate'
	DROP PROCEDURE [dbo].[spITItemInDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Update data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailUpdate
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8),
	@pivchItemTypeCode VARCHAR(10),
	@pivchSerialNo VARCHAR(50),
	@pivchBarcode VARCHAR(50),
	@pivchDescription VARCHAR(255),
	@pivchConditionCode INT,
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_Item WITH(NOLOCK)
				WHERE
					IsActive = 1
					AND item_type_code = @pivchItemTypeCode
					AND (
						SerialNo = @pivchSerialNo
						OR
						Barcode = @pivchBarcode
					)
			)
		)
		BEGIN
			SET @ErrMsg = 'Item with SerialNo '+@pivchSerialNo+ ' or Barcode ' +@pivchBarcode+ ' is already in database.'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemInDtl
		SET
			item_type_code=@pivchItemTypeCode,
			SerialNo=@pivchSerialNo,
			Barcode=@pivchBarcode,
			Description=@pivchDescription,
			ConditionCode=@pivchConditionCode,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemInDtlCode = @pivchItemInDetailCode
			and ITItemInCode = @pivchItemInCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInDetailView'
	DROP PROCEDURE [dbo].[spITItemInDetailView]
END
GO

PRINT 'CREATE PROCEDURE spITItemInDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk show data Item-In Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInDetailView		
	@pivchItemInDetailCode VARCHAR(10),
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ITItemInDtlCode,
		ITItemInCode,
		item_type_code,
		SerialNo,
		Barcode,
		Description,
		ConditionCode
	FROM
		IT_ItemInDtl WITH(NOLOCK)
	WHERE
		ITItemInDtlCode = @pivchItemInDetailCode
		AND ITItemInCode = @pivchItemInCode
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInInsert'
	DROP PROCEDURE [dbo].[spITItemInInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemInInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-29
**	Description		: SP untuk Insert Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInInsert
	@pidtmDateIn DATETIME,
	@piintBranchFrom INT,
	@pivchReceiveFrom varchar(20),
	@pivchPIC varchar(20),
	@pivchInputBy VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		
		INSERT INTO IT_ItemIn (
			ITItemInCode,
			Date,
			BranchId,
			ReceiveFrom,
			PIC,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemInCode(),
			@pidtmDateIn,
			CASE 
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			CASE 
				WHEN @pivchReceiveFrom = '' THEN NULL
				ELSE @pivchReceiveFrom
			END,
			@pivchPIC,
			'D',
			1,
			GETDATE(),
			@pivchInputBy
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInInsert
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInList'
	DROP PROCEDURE [dbo].[spITItemInList]
END
GO

PRINT 'CREATE PROCEDURE spITItemInList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-28
**	Description		: SP untuk show data Item yang masuk
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemInList]		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ITItemInCode,
					a.Date,
					a.BranchId,
					b.BranchName,
					a.ReceiveFrom,
					a.PIC,
					c.UserName,
					a.Status
				FROM
					IT_ItemIn AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
					INNER JOIN MsUsers AS c WITH(NOLOCK) ON a.PIC = c.UserId '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
		SET @sql = @sql + ' ORDER BY a.ITItemInCode DESC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInUpdate'
	DROP PROCEDURE [dbo].[spITItemInUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemInUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Data Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInUpdate
	@pivchItemInCode VARCHAR(8),
	@pidtmDateIn DATETIME,
	@piintBranchFrom INT,
	@pivchReceiveFrom VARCHAR(20),
	@pivchPIC VARCHAR(20),
	@pivchInputBy VARCHAR(20)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_ItemIn
		SET
			Date = @pidtmDateIn,
			BranchId = CASE 
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			ReceiveFrom = 
			CASE 
				WHEN @pivchReceiveFrom = '' THEN NULL
				ELSE @pivchReceiveFrom
			END,
			PIC = @pivchPIC,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemInCode = @pivchItemInCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemInUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemInUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemInUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInUpdateStatus
	@pivchItemInCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemInUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@MinID INT,
			@MaxID INT,
			@ItemTypeCode VARCHAR(10),
			@SerialNo VARCHAR(50),
			@Barcode VARCHAR(50)
		
		DECLARE @tmpDetail AS TABLE (
			ID INT IDENTITY,
			ITItemInDtlCode	VARCHAR(10),
			ITItemInCode VARCHAR(8),
			item_type_code VARCHAR(10),
			BranchId INT,
			SerialNo VARCHAR(50),
			Barcode VARCHAR(50),
			Description TEXT,
			ParentCode VARCHAR(12),
			ConditionCode INT
		)

		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE IT_ItemIn
			SET
				Status = @pivchStatus,
				ApprovalState = 1,
				update_date = getdate(),
				update_by = @pivchInputBy
			WHERE
				ITItemInCode = @pivchItemInCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			IF(
				NOT EXISTS(
					SELECT ''
					FROM IT_ItemInDtl WITH(NOLOCK)
					WHERE
						ITItemInCode = @pivchItemInCode
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END	
		
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemIn
				SET
					Status = @pivchStatus,
					ApprovalState = 2,
					created_by = @pivchInputBy,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemInCode = @pivchItemInCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				INSERT INTO @tmpDetail (
					ITItemInDtlCode,
					ITItemInCode,
					item_type_code,
					BranchId,
					SerialNo,
					Barcode,
					Description,
					ParentCode,
					ConditionCode
				)
				SELECT
					a.ITItemInDtlCode,
					a.ITItemInCode,
					a.item_type_code,
					b.BranchId,
					a.SerialNo,
					a.Barcode,
					a.Description,
					a.ParentCode,
					a.ConditionCode
				FROM
					IT_ItemInDtl AS a WITH(NOLOCK)
					INNER JOIN IT_ItemIn AS b WITH(NOLOCK) ON
						a.ITItemInCode = b.ITItemInCode
				WHERE
					a.ITItemInCode = @pivchItemInCode
					
				IF @@ERROR <> 0
					GOTO ExitSP

				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpDetail

				WHILE (@MinID <= @MaxID)
				BEGIN
					-- Verify Existing Item
					SELECT
						@ItemTypeCode = item_type_code,
						@SerialNo = SerialNo,
						@Barcode = Barcode
					FROM
						@tmpDetail
					WHERE
						ID = @MinID
						
					IF(
						EXISTS(
							SELECT ''
							FROM IT_Item WITH(NOLOCK)
							WHERE
								IsActive = 1
								AND item_type_code = @ItemTypeCode
								AND (
									SerialNo = @SerialNo
									OR
									Barcode = @Barcode
								)
						)
					)
					BEGIN
						SET @ErrMsg = 'Item with SerialNo ' + @SerialNo + ' or Barcode ' + @Barcode + ' is already in database.'
						GOTO ExitSP
					END
					
					INSERT INTO IT_Item (
						ITItemCode,
						ITItemInDtlCode,
						item_type_code,
						BranchId,
						SerialNo,
						Barcode,
						Description,
						ParentCode,
						ConditionCode,
						created_date,
						created_by
					)
					SELECT
						dbo.fnGenItemCode(),
						ITItemInDtlCode,
						item_type_code,
						BranchId,
						SerialNo,
						Barcode,
						Description,
						ParentCode,
						ConditionCode,
						GETDATE(),
						@pivchInputBy
					FROM
						@tmpDetail
					WHERE
						ID = @MinID

					SET @MinID = @MinID + 1
				END
			
				IF @@ERROR <> 0
					GOTO ExitSP
					
				UPDATE IT_ItemIn
				SET
					Status = @pivchStatus,
					ApprovalState = 3,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemInCode = @pivchItemInCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemInUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemInUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO    

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemInView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemInView'
	DROP PROCEDURE [dbo].[spITItemInView]
END
GO

PRINT 'CREATE PROCEDURE spITItemInView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemInView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-29
**	Description		: SP untuk show detail data Item-In
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemInView		
	@pivchItemInCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemInCode,
		a.Date,
		ReceiveType = CASE
						WHEN a.BranchId IS NOT NULL THEN '1'
						WHEN a.ReceiveFrom IS NOT NULL THEN '2'
					END,
		a.BranchId,
		d.BranchName as BranchNameFrom,	
		a.ReceiveFrom,
		a.PIC,
		b.UserName,
		a.Status,
		a.created_by AS CreatedBy,
		c.UserName AS CreatedName,
		a.ApprovalState
	FROM
		IT_ItemIn AS a WITH(NOLOCK) 
		INNER JOIN MsUsers AS b ON a.PIC = b.UserId
		LEFT JOIN MsUsers AS c ON a.created_by = c.UserId
		LEFT JOIN MsBranch AS d ON a.BranchId = d.BranchId
	WHERE
		a.ITItemInCode = @pivchItemInCode
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemList'
	DROP PROCEDURE [dbo].[spITItemList]
END
GO

PRINT 'CREATE PROCEDURE spITItemList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk show data List Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemList]		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					A.ITItemCode,
					A.ITItemInDtlCode,
					A.item_type_code,
					B.item_type_name,
					A.SerialNo,
					A.Barcode,
					A.Description,
					C.ConditionName,
					A.StatusOut,
					D.BranchCode,
					ISNULL(D.BranchName,''Warehouse'') AS BranchName,
					A.UsedBy,
					E.PrivilegeName
				FROM
					IT_Item A WITH(NOLOCK)
					INNER JOIN MsItemType B WITH(NOLOCK) ON A.item_type_code = B.item_type_code	
					INNER JOIN MsCondition C WITH(NOLOCK)  ON A.ConditionCode = C.ConditionCode
					LEFT JOIN MsBranch D WITH(NOLOCK)  ON A.BranchId = D.BranchId
					LEFT JOIN MsPrivilege E WITH(NOLOCK)  ON A.PrivilegeCode = E.PrivilegeCode'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	SET @sql = @sql + ' ORDER BY A.ITItemCode DESC' 
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutInsert'
	DROP PROCEDURE [dbo].[spITItemOutInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Insert Item-OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutInsert
	@pivchItemCode VARCHAR(10),
	@pidtmDateOut DATETIME,
	@piintBranchFrom INT,
	@pivchConditionCode INT,
	@piintStatusOut INT,
	@pivchDescription VARCHAR(255),
	@pivchVendorName VARCHAR(50),
	@pivchPIC varchar(50),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		IF(
			EXISTS(
				SELECT ''
				FROM IT_Item WITH(NOLOCK)
				WHERE
					ITItemCode = @pivchItemCode
					AND (
						ITItemOutCode IS NOT NULL
						OR IsActive = 0
					)
			)
		)
		BEGIN
			SET @ErrMsg = 'Item already in history or item already Dispose'
			GOTO ExitSP
		END
		
		INSERT INTO IT_ItemOut (
			ITItemOutCode,
			ITItemCode,
			Date,
			BranchId,
			ConditionCode,
			StatusOut,
			Description,
			VendorName,
			PIC,
			Status,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemOutCode(),
			@pivchItemCode,
			@pidtmDateOut,
			CASE
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			@pivchConditionCode,
			@piintStatusOut,
			@pivchDescription,
			CASE
				WHEN @pivchVendorName = '' THEN NULL
				ELSE @pivchVendorName
			END,
			@pivchPIC,
			'D',
			GETDATE(),
			@pivchInputBy
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemOutInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutList'
	DROP PROCEDURE [dbo].[spITItemOutList]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-14
**	Description		: SP untuk show data Item yang OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemOutList]		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ITItemOutCode,	 
					a.ITItemCode,
					e.item_type_name,
					d.SerialNo,
					a.Date,	 
					a.BranchId,
					b.BranchName,	 
					a.ConditionCode, 
					f.ConditionName,
					a.StatusOut,
					a.Description,
					a.VendorName,
					a.PIC,
					c.UserName,	
					a.Status,
					a.ApprovalState,
					a.created_by AS CreatedName
				FROM
					IT_ItemOut AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON a.BranchId = b.BranchId
					INNER JOIN MsUsers AS c WITH(NOLOCK) ON a.PIC = c.UserId
					INNER JOIN IT_Item AS d WITH(NOLOCK) ON a.ITItemCode = d.ITItemCode
					INNER JOIN MsItemType AS e WITH(NOLOCK) ON d.item_type_code = e.item_type_code
					INNER JOIN MsCondition AS f WITH(NOLOCK) ON a.ConditionCode = f.ConditionCode
			'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
		SET @sql = @sql + ' ORDER BY a.ITItemOutCode DESC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdate'
	DROP PROCEDURE [dbo].[spITItemOutUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-13
**	Description		: SP untuk Update Data Item-OUT
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdate
	@pivchItemOutCode VARCHAR(8),
	@pivchItemCode VARCHAR(10),
	@pidtmDateOut DATETIME,
	@piintBranchFrom INT,
	@pivchConditionCode INT,
	@piintStatusOut INT,
	@pivchDescription VARCHAR(255),
	@pivchVendorName VARCHAR(50),
	@pivchPIC varchar(50),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_Item WITH(NOLOCK)
				WHERE
					ITItemCode = @pivchItemCode
					AND (
						ITItemOutCode IS NOT NULL
						OR IsActive = 0
					)
			)
		)
		BEGIN
			SET @ErrMsg = 'Item already in history or item already Dispose'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemOut
		SET
			ITItemCode = @pivchItemCode,
			Date = @pidtmDateOut,
			BranchId = CASE 
							WHEN @piintBranchFrom = 0 THEN NULL
							ELSE @piintBranchFrom
						END,
			ConditionCode = @pivchConditionCode,
			StatusOut = @piintStatusOut,
			Description = @pivchDescription,
			VendorName = CASE
							WHEN @piintStatusOut = 1 THEN @pivchVendorName
							ELSE NULL
						END,
			PIC = @pivchPIC,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemOutCode = @pivchItemOutCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemOutUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemOutUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdateStatus
	@pivchItemOutCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@ITItemCode VARCHAR(10),
			@ConditionCode INT,
			@StatusOut INT
		
		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE IT_ItemOut
			SET
				Status = @pivchStatus,
				ApprovalState = 1,
				update_date = getdate(),
				update_by = @pivchInputBy
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			SELECT
				@ITItemCode = ITItemCode,
				@ConditionCode = ConditionCode,
				@StatusOut = StatusOut
			FROM
				IT_ItemOut WITH(NOLOCK)
			WHERE
				ITItemOutCode = @pivchItemOutCode
				
			IF(
				EXISTS(
					SELECT ''
					FROM IT_Item WITH(NOLOCK)
					WHERE
						ITItemCode = @ITItemCode
						AND (
							ITItemOutCode IS NOT NULL
							OR IsActive = 0
						)
				)
			)
			BEGIN
				SET @ErrMsg = 'Item already in history or item already Dispose'
				GOTO ExitSP
			END
			
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemOut
				SET
					Status = @pivchStatus,
					ApprovalState = 2,
					created_by = @pivchInputBy,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				UPDATE IT_ItemOut
				SET
					Status = @pivchStatus,
					ApprovalState = 3,
					RepairStatus = CASE
										WHEN @StatusOut = '1' THEN 'D'
										ELSE NULL
									END,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
				INSERT INTO IT_Item_History
				SELECT * FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @ITItemCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
				
				UPDATE IT_Item
				SET
					ITItemOutCode = @pivchItemOutCode,
					IsActive = CASE
									WHEN @StatusOut = '2' THEN 0
									ELSE IsActive
								END,
					ConditionCode = @ConditionCode,
					StatusOut = @StatusOut,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemCode = @ITItemCode
					
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemOutUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdateStatusRepair]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdateStatusRepair'
	DROP PROCEDURE [dbo].[spITItemOutUpdateStatusRepair]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdateStatusRepair'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdateStatusRepair
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdateStatusRepair
	@pivchItemOutCode VARCHAR(8),
	@pivchRepairStatus VARCHAR(1),
	@piintRepairState INT,
	@piintRepairCondition INT,
	@pivchRepairDescription VARCHAR(255),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutUpdateStatusRepair
		DECLARE
			@ErrMsg VARCHAR(2000),
			@ITItemCode VARCHAR(10),
			@RepairState INT,
			@RepairCondition INT
		
		-- Reject
		IF (@pivchRepairStatus = 'D')
		BEGIN --1
			UPDATE IT_ItemOut
			SET
				RepairStatus = @pivchRepairStatus,
				ApprovalState = 3,
				update_date = getdate(),
				update_by = @pivchInputBy
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			SELECT
				@ITItemCode = ITItemCode,
				@RepairState = RepairState,
				@RepairCondition = RepairCondition
			FROM
				IT_ItemOut WITH(NOLOCK)
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			-- RFA
			IF (@pivchRepairStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemOut
				SET
					RepairStatus = @pivchRepairStatus,
					RepairState = @piintRepairState,
					RepairCondition = CASE
										WHEN @piintRepairState = '1' THEN @piintRepairCondition
										ELSE NULL
									END,
					RepairDescription = @pivchRepairDescription,
					ApprovalState = 4,
					created_by = @pivchInputBy,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchRepairStatus = 'A')
			BEGIN --3
				UPDATE IT_ItemOut
				SET
					RepairStatus = @pivchRepairStatus,
					ApprovalState = 5,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
				INSERT INTO IT_Item_History
				SELECT * FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @ITItemCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
				
				UPDATE IT_Item
				SET
					ITItemOutCode = CASE
										WHEN @RepairState = '1' THEN NULL -- Return
										ELSE ITItemOutCode
									END,
					ConditionCode = CASE
										WHEN @RepairState = '1' THEN @RepairCondition -- Return
										ELSE ConditionCode
									END,
					IsActive = CASE
									WHEN @RepairState = '2' THEN 0
									ELSE IsActive
								END,
					StatusOut = CASE
									WHEN @RepairState = '1' THEN 3 -- Return
									WHEN @RepairState = '2' THEN 4 -- Replace
									ELSE ITItemOutCode
								END,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemCode = @ITItemCode
					
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemOutUpdateStatusRepair
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdateStatusRepair
	END
END
GO

SET NOCOUNT OFF
GO 

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutView'
	DROP PROCEDURE [dbo].[spITItemOutView]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-14
**	Description		: SP untuk show detail data Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutView		
	@pivchItemOutCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemOutCode,	 
		a.ITItemCode,
		a.ITItemCode + ' - ' + b.SerialNo + ' - ' + b.Description AS ITItemName,
		b.item_type_code,
		d.item_type_name,
		a.Date,	 
		a.BranchId,
		c.BranchName,	 
		a.StatusOut,
		a.ConditionCode,
		f.ConditionName,
		a.Description,
		a.VendorName,
		a.PIC,
		e.UserName AS PICName,
		a.Status,
		a.RepairStatus,
		a.RepairState,
		a.RepairCondition,
		g.ConditionName AS RepairConditionName,
		a.RepairDescription,
		a.ApprovalState,
		a.created_by AS CreatedBy
	FROM
		IT_ItemOut AS a WITH(NOLOCK)
		INNER JOIN IT_Item AS b WITH(NOLOCK) ON
			a.ITItemCode = b.ITItemCode
		LEFT JOIN MsBranch AS c ON
			a.BranchId = c.BranchId
		INNER JOIN MsItemType AS d WITH(NOLOCK) ON
			b.item_type_code = d.item_type_code
		INNER JOIN MsUsers AS e WITH(NOLOCK) ON
			a.PIC = e.UserId
		INNER JOIN MsCondition AS f WITH(NOLOCK) ON
			a.ConditionCode = f.ConditionCode
		LEFT JOIN MsCondition AS g WITH(NOLOCK) ON
			a.RepairCondition = g.ConditionCode
	WHERE
		a.ITItemOutCode = @pivchItemOutCode
END
GO

SET NOCOUNT OFF
GO   

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailDelete'
	DROP PROCEDURE [dbo].[spITItemTransDetailDelete]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Delete data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailDelete
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ITItemTransDetailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM
			IT_ItemTransDtl
		WHERE
			ITItemTransDtlCode = @pivchItemTransDetailCode
			AND ITItemTransCode = @pivchItemTransCode
		
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ITItemTransDetailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ITItemTransDetailDelete
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailInsert'
	DROP PROCEDURE [dbo].[spITItemTransDetailInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi	
**	Created Date	: 2013-06-10
**	Description		: SP untuk Insert data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailInsert
	@pivchItemTransCode VARCHAR(8),
	@pivchItemCode VARCHAR(10),
	@pivchConditionCode INT,
	@pivchUsedBy VARCHAR(50),
	@pivchPrivilegeCode VARCHAR(4),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransDetailInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_ItemTransDtl WITH(NOLOCK)
				WHERE
					ITItemTransCode = @pivchItemTransCode
					AND ITItemCode = @pivchItemCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Item already in database'
			GOTO ExitSP
		END
		
		INSERT INTO IT_ItemTransDtl (
			ITItemTransDtlCode,
			ITItemTransCode,
			ITItemCode,
			ConditionCode,
			UsedBy,
			PrivilegeCode,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemTransDetailCode(@pivchItemTransCode),
			@pivchItemTransCode,
			@pivchItemCode,
			@pivchConditionCode,
			@pivchUsedBy,
			CASE
				WHEN @pivchPrivilegeCode = '' THEN NULL
				ELSE @pivchPrivilegeCode
			END,
			GETDATE(),
			@pivchInputBy
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransDetailInsert
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransDetailInsert
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailList'
	DROP PROCEDURE [dbo].[spITItemTransDetailList]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk show data Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailList		
	@pivchWhereBy VARCHAR(1000),
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.*,
					b.SerialNo,
					b.Barcode,
					b.Description,
					b.ParentCode,
					c.item_type_name,
					d.ConditionName,
					e.PrivilegeName
				FROM
					IT_ItemTransDtl AS a WITH(NOLOCK)
					INNER JOIN IT_Item AS b WITH(NOLOCK) ON (a.ITItemCode = b.ITItemCode)
					INNER JOIN MsItemType AS c WITH(NOLOCK) ON (b.item_type_code = c.item_type_code)
					LEFT JOIN MsCondition AS d WITH(NOLOCK) ON (a.ConditionCode = d.ConditionCode)
					LEFT JOIN MsPrivilege AS e WITH(NOLOCK) ON (a.PrivilegeCode = e.PrivilegeCode)
				WHERE
					a.ITItemTransCode = ''' + @pivchItemTransCode + ''''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailUpdate'
	DROP PROCEDURE [dbo].[spITItemTransDetailUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk Update data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailUpdate
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8),
	@pivchItemCode VARCHAR(10),
	@pivchConditionCode INT,
	@pivchUsedBy VARCHAR(50),
	@pivchPrivilegeCode VARCHAR(4),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransDetailUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM IT_ItemTransDtl WITH(NOLOCK)
				WHERE
					ITItemTransCode = @pivchItemTransCode
					AND ITItemCode = @pivchItemCode
					AND ITItemTransDtlCode <> @pivchItemTransDetailCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Item already in database'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemTransDtl
		SET
			ITItemCode=@pivchItemCode,
			ConditionCode=@pivchConditionCode,
			UsedBy=@pivchUsedBy,
			PrivilegeCode=  CASE
								WHEN @pivchPrivilegeCode = '' THEN NULL
								ELSE @pivchPrivilegeCode
							END,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemTransDtlCode = @pivchItemTransDetailCode
			and ITItemTransCode = @pivchItemTransCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransDetailUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransDetailUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransDetailView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransDetailView'
	DROP PROCEDURE [dbo].[spITItemTransDetailView]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransDetailView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransDetailView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-10
**	Description		: SP untuk show data Item Transfer Detail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransDetailView		
	@pivchItemTransDetailCode VARCHAR(10),
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemTransDtlCode,
		a.ITItemTransCode,
		a.ITItemCode,
		a.ConditionCode,
		a.UsedBy,
		a.PrivilegeCode,
		b.item_type_code
	FROM
		IT_ItemTransDtl AS a WITH(NOLOCK)
		INNER JOIN IT_Item AS b WITH(NOLOCK) ON
			a.ITItemCode = b.ITItemCode
	WHERE
		a.ITItemTransDtlCode = @pivchItemTransDetailCode
		AND a.ITItemTransCode = @pivchItemTransCode
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransInsert'
	DROP PROCEDURE [dbo].[spITItemTransInsert]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk Insert Item Transfer hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransInsert
	@piintBranchFrom INT,
	@piintBranchTo INT,
	@pidtmDateTrans DATETIME,
	@pivchInputBy VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransInsert
		DECLARE
			@ErrMsg VARCHAR(2000)

		IF(@piintBranchFrom = @piintBranchTo)
		BEGIN
			SET @ErrMsg = 'Invalid Destination Branch, Branch To cannot same with Branch From'
			GOTO ExitSP
		END
		
		INSERT INTO IT_ItemTrans (
			ITItemTransCode,
			BranchId_From,
			BranchId_To,
			DateTrans,
			Status,
			ApprovalState,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenItemTransCode(),
			CASE
				WHEN @piintBranchFrom = 0 THEN NULL
				ELSE @piintBranchFrom
			END,
			CASE
				WHEN @piintBranchTo = 0 THEN NULL
				ELSE @piintBranchTo
			END,
			@pidtmDateTrans,
			'D',
			1,
			GETDATE(),
			@pivchInputBy
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransInsert
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransList'
	DROP PROCEDURE [dbo].[spITItemTransList]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show data Item Tranfer Hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[spITItemTransList]		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ITItemTransCode,
					ISNULL(b.BranchName,''Warehouse'') AS BranchFrom,
					ISNULL(c.BranchName,''Warehouse'') AS BranchTo,
					a.DateTrans,
					a.Status
				FROM
					IT_ItemTrans AS a WITH(NOLOCK)
					LEFT JOIN MsBranch AS b WITH(NOLOCK) ON b.BranchId = a.BranchId_From
					LEFT JOIN MsBranch AS c WITH(NOLOCK) ON c.BranchId = a.BranchId_To '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy

	SET @sql = @sql + ' ORDER BY a.ITItemTransCode DESC'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransUpdate'
	DROP PROCEDURE [dbo].[spITItemTransUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk Update Data Item Transfer hd
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransUpdate
	@pivchItemTransCode VARCHAR(8),
	@piintBranchFrom INT,
	@piintBranchTo INT,
	@pidtmDateTrans DATETIME,
	@pivchInputBy VARCHAR(20)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(@piintBranchFrom = @piintBranchTo)
		BEGIN
			SET @ErrMsg = 'Invalid Destination Branch, Branch To cannot same with Branch From'
			GOTO ExitSP
		END
		
		UPDATE IT_ItemTrans
		SET
			BranchId_From = CASE
								WHEN @piintBranchFrom = 0 THEN NULL
								ELSE @piintBranchFrom
							END,
			BranchId_To = CASE
								WHEN @piintBranchTo = 0 THEN NULL
								ELSE @piintBranchTo
							END,
			DateTrans = @pidtmDateTrans,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemTransCode = @pivchItemTransCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTransUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransUpdateStatus'
	DROP PROCEDURE [dbo].[spITItemTransUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item Transfer
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransUpdateStatus
	@pivchItemTransCode VARCHAR(8),
	@pivchStatus VARCHAR(1),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTransUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@MinID INT,
			@MaxID INT	
		
		DECLARE @tmpDetail AS TABLE (
			ID INT IDENTITY,
			ITItemTransDtlCode VARCHAR(10),
			ITItemTransCode VARCHAR(8),
			ITItemCode VARCHAR(10),
			ConditionCode INT,
			UsedBy VARCHAR(50),
			PrivilegeCode VARCHAR(4),
			BranchId_From INT,
			BranchId_To INT
		)

		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE IT_ItemTrans
			SET
				Status = @pivchStatus,
				ApprovalState = 1,
				update_date = getdate(),
				update_by = @pivchInputBy
			WHERE
				ITItemTransCode = @pivchItemTransCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			IF(
				NOT EXISTS(
					SELECT ''
					FROM IT_ItemTransDtl WITH(NOLOCK)
					WHERE
						ITItemTransCode = @pivchItemTransCode
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END	
		
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemTrans
				SET
					Status = @pivchStatus,
					ApprovalState = 2,
					created_by = @pivchInputBy,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemTransCode = @pivchItemTransCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3
				INSERT INTO @tmpDetail (
					ITItemTransDtlCode,
					ITItemTransCode,
					ITItemCode,
					ConditionCode,
					UsedBy,
					PrivilegeCode,
					BranchId_From,
					BranchId_To
				)
				SELECT
					a.ITItemTransDtlCode,
					a.ITItemTransCode,
					a.ITItemCode,
					a.ConditionCode,
					a.UsedBy,
					a.PrivilegeCode,
					b.BranchId_From,
					b.Branchid_To
				FROM
					IT_ItemTransDtl AS a WITH(NOLOCK)
					INNER JOIN IT_ItemTrans AS b WITH(NOLOCK) ON
						a.ITItemTransCode = b.ITItemTransCode
				WHERE
					b.ITItemTransCode = @pivchItemTransCode
					
				IF @@ERROR <> 0
					GOTO ExitSP

				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpDetail

				WHILE (@MinID <= @MaxID)
				BEGIN
					-- Validasi Detail
					IF (
						NOT EXISTS (
							SELECT ''
							FROM
								@tmpDetail AS a
								INNER JOIN IT_Item AS b WITH(NOLOCK) ON
									a.ITItemCode = b.ITItemCode
							WHERE
								b.IsActive = 1
								AND (
									ISNULL(a.BranchId_From,0) = ISNULL(b.BranchId,0)
									OR
									b.ITItemOutCode IS NOT NULL
								)
								AND a.ID = @MinID
						)
					)
					BEGIN
						SELECT
							@ErrMsg = 'Invalid Data Detail, please check detail Item ' + ITItemCode
						FROM
							@tmpDetail
						WHERE
							ID = @MinID
							
						GOTO ExitSP
					END
					
					UPDATE
						a
					SET
						a.ITItemTransDtlCode = b.ITItemTransDtlCode,
						a.ConditionCode = b.ConditionCode,
						a.UsedBy = b.UsedBy,
						a.PrivilegeCode = b.PrivilegeCode,
						a.BranchId = b.Branchid_To,
						a.update_date = GETDATE(),
						a.update_by = @pivchInputBy
					FROM
						IT_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpDetail AS b ON
							a.ITItemCode = b.ITItemCode
					WHERE
						a.IsActive = 1
						AND b.ID = @MinID
					
					IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) -- Check Error dan Check Affected Update Row
					BEGIN
						SET @ErrMsg = 'Verify Data Detail Error'
						GOTO ExitSP
					END
					
					-- Update History
					INSERT INTO IT_Item_History
					SELECT
						a.*
					FROM
						IT_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpDetail AS b ON
							a.ITItemCode = b.ITItemCode
					WHERE
						b.ID = @MinID

					IF @@ERROR <> 0
						GOTO ExitSP
						
					SET @MinID = @MinID + 1
				END
					
				UPDATE IT_ItemTrans
				SET
					Status = @pivchStatus,
					ApprovalState = 3,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemTransCode = @pivchItemTransCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemTransUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTransUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO     

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemTransView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemTransView'
	DROP PROCEDURE [dbo].[spITItemTransView]
END
GO

PRINT 'CREATE PROCEDURE spITItemTransView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemTransView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-07
**	Description		: SP untuk show detail data Item Transfer 
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemTransView		
	@pivchItemTransCode VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ITItemTransCode,
		a.BranchId_From,
		ISNULL(b.BranchName,'Warehouse') AS BranchNameFrom,
		a.BranchId_To,
		ISNULL(c.BranchName,'Warehouse') AS BranchNameTo,
		a.DateTrans,
		a.Status,
		a.created_by AS CreatedBy,
		d.UserName AS CreatedName,
		a.ApprovalState
	FROM
		IT_ItemTrans AS a WITH(NOLOCK)
		LEFT JOIN MsBranch AS b WITH(NOLOCK) ON b.BranchId = a.BranchId_From
		LEFT JOIN MsBranch AS c WITH(NOLOCK) ON c.BranchId = a.BranchId_To
		LEFT JOIN MsUsers AS d WITH(NOLOCK) ON a.created_by = d.UserId
	WHERE
		a.ITItemTransCode = @pivchItemTransCode
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemUpdate'
	DROP PROCEDURE [dbo].[spITItemUpdate]
END
GO

PRINT 'CREATE PROCEDURE spITItemUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk Update Data Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemUpdate
	@pivchItemCode VARCHAR(10),
	@pivchDescription VARCHAR(255),
	@pivchConditionCode INT,
	@pivchInputBy VARCHAR(50)
	
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE IT_Item
		SET
			Description = @pivchDescription,
			ConditionCode = @pivchConditionCode,
			update_date = GETDATE(),
			update_by = @pivchInputBy
		WHERE
			ITItemCode = @pivchItemCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
		INSERT INTO IT_Item_History
		SELECT * FROM IT_Item
		WHERE
			ITItemCode = @pivchItemCode
		
		IF @@ERROR <> 0
			GOTO ExitSP
				
	COMMIT TRAN ItemUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
  IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemView'
	DROP PROCEDURE [dbo].[spITItemView]
END
GO

PRINT 'CREATE PROCEDURE spITItemView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-05
**	Description		: SP untuk show detail data Item
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemView		
	@pivchItemCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		A.ITItemCode,
		A.ITItemInDtlCode,
		A.ITItemTransDtlCode,
		A.ITItemOutCode,
		B.item_type_code,
		B.item_type_name,
		A.SerialNo,
		A.Barcode,
		A.Description,
		C.ConditionCode,
		C.ConditionName,
		A.StatusOut,
		D.BranchId,
		D.BranchName,
		A.UsedBy,
		E.PrivilegeCode,
		E.PrivilegeName,
		A.IsActive
	FROM
		IT_Item as A WITH(NOLOCK)
		INNER JOIN MsItemType as B WITH(NOLOCK) ON A.item_type_code = B.item_type_code	
		INNER JOIN MsCondition as C WITH(NOLOCK)  ON A.ConditionCode = C.ConditionCode
		LEFT JOIN MsBranch as D WITH(NOLOCK)  ON A.BranchId = D.BranchId
		LEFT JOIN MsPrivilege as E WITH(NOLOCK)  ON A.PrivilegeCode = E.PrivilegeCode
	WHERE
		A.ITItemCode = @pivchItemCode
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskDelete'
	DROP PROCEDURE [dbo].[spScheduleTaskDelete]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskDelete
	@pivchScheduleNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ScheduleTask
		SET
			Status = '0'
		WHERE
			ScheduleNo = @pivchScheduleNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ScheduleTaskDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskDelete
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskFinish]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskFinish'
	DROP PROCEDURE [dbo].[spScheduleTaskFinish]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskFinish'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskFinish
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Finish Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskFinish
	@pivchScheduleNo VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskFinish
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE
			IT_ScheduleTask
		SET
			Status = '2'
		WHERE
			ScheduleNo = @pivchScheduleNo
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ScheduleTaskFinish
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskFinish
	END
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskInsert'
	DROP PROCEDURE [dbo].[spScheduleTaskInsert]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskInsert
	@pivchScheduleType VARCHAR(1),
    @pivchScheduleTitle VARCHAR(255),
    @pidtmStartDate DATETIME,
    @pidtmEndDate DATETIME,
    @pivchIntervalBy VARCHAR(1),
    @piintIntervalRange INT,
    @pivchIntervalHour VARCHAR(2),
    @pivchIntervalMinute VARCHAR(2),
    @pivchDescription VARCHAR(255),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskInsert
		DECLARE
			@ErrMsg VARCHAR(2000)

		--* Default Value
		IF CONVERT(VARCHAR(8),@pidtmStartDate,112) = '17530101'
			SET @pidtmStartDate = NULL

		IF CONVERT(VARCHAR(8),@pidtmEndDate,112) = '17530101'
			SET @pidtmEndDate = NULL

		--* Validation
		IF (@pidtmEndDate IS NOT NULL)
			AND
			(CONVERT(VARCHAR(8),@pidtmStartDate,112) > CONVERT(VARCHAR(8),@pidtmEndDate,112))
		BEGIN
			SET @ErrMsg = 'End Date (' + CONVERT(VARCHAR(10),@pidtmEndDate,105) + ') must bigger or equivalent than Start Date (' + CONVERT(VARCHAR(10),@pidtmStartDate,105) + ')'
			GOTO ExitSP	
		END
		
		IF (@piintIntervalRange < 0)
		BEGIN
			SET @ErrMsg = 'Interval must be larger than zero (0)'
			GOTO ExitSP	
		END

		IF (
			(@pivchIntervalBy = '2')
			AND
			(
				ISDATE(
					CONVERT(VARCHAR(8),@pidtmStartDate,120)
					+
					CONVERT(VARCHAR,@piintIntervalRange)
				) = 0
			)
		)
		BEGIN
			SET @ErrMsg = 'Range Date Invalid'
			GOTO ExitSP	
		END
		
		--*
		INSERT INTO IT_ScheduleTask (
			ScheduleNo,
			ScheduleType,
			ScheduleTitle,
			StartDate,
			EndDate,
			IntervalBy,
			IntervalRange,
			IntervalHour,
			IntervalMinute,
			Description,
			Status,
			created_date,
			created_by
		)
		SELECT
			dbo.fnGenScheduleNo(),
			@pivchScheduleType,
			@pivchScheduleTitle,
			@pidtmStartDate,
			@pidtmEndDate,
			@pivchIntervalBy,
			@piintIntervalRange,
			@pivchIntervalHour,
			@pivchIntervalMinute,
			@pivchDescription,
			'1',
			GETDATE(),
			@pivchInputID
		
		IF @@ERROR <> 0
			GOTO ExitSP
		
	COMMIT TRAN ScheduleTaskInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskInsert
	END
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskList'
	DROP PROCEDURE [dbo].[spScheduleTaskList]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000)
	
	SET @sql = 'SELECT
					a.ScheduleNo,
					a.ScheduleType,
					a.ScheduleTitle,
					a.Description,
					a.StartDate,
					a.EndDate,
					a.IntervalBy,
					a.IntervalRange,
					a.IntervalHour,
					a.IntervalMinute,
					a.IntervalHour + '':'' + a.IntervalMinute AS IntervalTime,
					a.Status,
					a.created_date,
					a.created_by,
					b.UserName AS UserCreated,
					a.update_date,
					a.update_by,
					c.UserName AS UserUpdate
				FROM
					IT_ScheduleTask AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.created_by = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.update_by = c.UserId
				WHERE
					a.Status <> ''0'''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY a.ScheduleNo DESC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskNextList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskNextList'
	DROP PROCEDURE [dbo].[spScheduleTaskNextList]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskNextList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskNextList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Next Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskNextList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(8000)

	SET @sql = 'DECLARE
					@MinID INT,
					@MaxID INT

				DECLARE @tmpSchedule AS TABLE (
					ID INT IDENTITY,
					ScheduleNo VARCHAR(8),
					StartDate DATETIME,
					EndDate DATETIME,
					IntervalBy VARCHAR(1),
					IntervalRange INT,
					IntervalHour VARCHAR(2),
					IntervalMinute VARCHAR(2),
					NextDate DATETIME
				)

				--*
				INSERT INTO @tmpSchedule (
					ScheduleNo,
					StartDate,
					EndDate,
					IntervalBy,
					IntervalRange,
					IntervalHour,
					IntervalMinute
				)
				SELECT
					ScheduleNo,
					StartDate,
					EndDate,
					IntervalBy,
					IntervalRange,
					IntervalHour,
					IntervalMinute
				FROM
					IT_ScheduleTask WITH(NOLOCK)
				WHERE
					Status = ''1''
					AND (
						(EndDate IS NULL)
						OR
						(CONVERT(VARCHAR(8),EndDate,112) >= CONVERT(VARCHAR(8),GETDATE(),112))
					)
				
				--*
				SELECT
					@MinID = MIN(ID),
					@MaxID = MAX(ID)
				FROM
					@tmpSchedule

				--*
				DECLARE
					@StartDate DATETIME,
					@EndDate DATETIME,
					@IntervalBy VARCHAR(1),
					@IntervalRange INT,
					@IntervalHour VARCHAR(2),
					@IntervalMinute VARCHAR(2),
					@NextDate DATETIME,
					@DiffDate INT,
					@TmpDate DATETIME
		
				WHILE (@MinID <= @MaxID)
				BEGIN
					SELECT
						@StartDate = StartDate,
						@EndDate = EndDate,
						@IntervalBy = IntervalBy,
						@IntervalRange = IntervalRange,
						@IntervalHour = IntervalHour,
						@IntervalMinute = IntervalMinute,
						@NextDate = NULL,
						@DiffDate = NULL
					FROM
						@tmpSchedule
					WHERE
						ID = @MinID

					SET @DiffDate = DATEDIFF(DAY,@StartDate,GETDATE())

					IF @IntervalBy = ''1''	-- Day
					BEGIN
						IF @DiffDate < 0
						BEGIN
							SET @NextDate = @StartDate
						END
						ELSE IF (@DiffDate % @IntervalRange) = 0
						BEGIN
							SET @NextDate = GETDATE()
						END
						ELSE
						BEGIN
							SET @NextDate = DATEADD(DAY, @IntervalRange - (@DiffDate % @IntervalRange), GETDATE())
						END

						SET @NextDate = CONVERT(DATETIME, CONVERT(VARCHAR(10), @NextDate, 120) + '' '' + @IntervalHour + '':'' + @IntervalMinute)
					END
					ELSE IF @IntervalBy = ''2''	-- Date
					BEGIN
						IF @DiffDate < 0
						BEGIN
							SET @TmpDate = @StartDate
						END
						ELSE
						BEGIN
							IF (DATEPART(DAY,GETDATE()) > @IntervalRange)
							BEGIN
								SET @TmpDate = CONVERT(VARCHAR(7), DATEADD(MONTH,1,GETDATE()), 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange)
							END
							ELSE
							BEGIN
								SET @TmpDate = CONVERT(VARCHAR(7), GETDATE(), 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange)
							END
						END
						
						SET @NextDate = CONVERT(DATETIME, CONVERT(VARCHAR(7), @TmpDate, 120) + ''-'' + CONVERT(VARCHAR,@IntervalRange) + '' '' + @IntervalHour + '':'' + @IntervalMinute)
					END

					UPDATE
						@tmpSchedule
					SET
						NextDate = @NextDate
					WHERE
						ID = @MinID

					SET @MinID = @MinID + 1
				END
				
				--*
				DELETE FROM @tmpSchedule
				WHERE
					EndDate IS NOT NULL
					AND	NextDate > EndDate
				
				--*
				SELECT
					a.ScheduleNo,
					a.ScheduleType,
					a.ScheduleTitle,
					a.Description,
					a.StartDate,
					a.EndDate,
					a.IntervalBy,
					a.IntervalRange,
					a.IntervalHour,
					a.IntervalMinute,
					a.IntervalHour + '':'' + a.IntervalMinute AS IntervalTime,
					a.Status,
					a.created_date,
					a.created_by,
					b.UserName AS UserCreated,
					a.update_date,
					a.update_by,
					c.UserName AS UserUpdate,
					CONVERT(VARCHAR,d.NextDate,105) + '' '' + CONVERT(VARCHAR(5),d.NextDate,114) AS NextDate
				FROM
					IT_ScheduleTask AS a WITH(NOLOCK)
					INNER JOIN MsUsers AS b WITH(NOLOCK) ON
						a.created_by = b.UserId
					LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
						a.update_by = c.UserId
					INNER JOIN @tmpSchedule AS d ON
						a.ScheduleNo = d.ScheduleNo
				WHERE
					a.Status = ''1'''
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' AND ' + @pivchWhereBy
	
	SET @sql = @sql + ' ORDER BY d.NextDate ASC'
	
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskUpdate'
	DROP PROCEDURE [dbo].[spScheduleTaskUpdate]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskUpdate
	@pivchScheduleNo VARCHAR(8),
	@pivchScheduleType VARCHAR(1),
    @pivchScheduleTitle VARCHAR(255),
    @pidtmStartDate DATETIME,
    @pidtmEndDate DATETIME,
    @pivchIntervalBy VARCHAR(1),
    @piintIntervalRange INT,
    @pivchIntervalHour VARCHAR(2),
    @pivchIntervalMinute VARCHAR(2),
    @pivchStatus VARCHAR(1),
    @pivchDescription VARCHAR(255),
    @pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ScheduleTaskUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		--* Default Value
		IF CONVERT(VARCHAR(8),@pidtmStartDate,112) = '17530101'
			SET @pidtmStartDate = NULL

		IF CONVERT(VARCHAR(8),@pidtmEndDate,112) = '17530101'
			SET @pidtmEndDate = NULL

		--* Validation
		IF (@pidtmEndDate IS NOT NULL)
			AND
			(CONVERT(VARCHAR(8),@pidtmStartDate,112) > CONVERT(VARCHAR(8),@pidtmEndDate,112))
		BEGIN
			SET @ErrMsg = 'End Date (' + CONVERT(VARCHAR(10),@pidtmEndDate,105) + ') must bigger or equivalent than Start Date (' + CONVERT(VARCHAR(10),@pidtmStartDate,105) + ')'
			GOTO ExitSP	
		END
		
		IF (@piintIntervalRange < 0)
		BEGIN
			SET @ErrMsg = 'Interval must be larger than zero (0)'
			GOTO ExitSP	
		END

		IF (
			(@pivchIntervalBy = '2')
			AND
			(
				ISDATE(
					CONVERT(VARCHAR(8),@pidtmStartDate,120)
					+
					CONVERT(VARCHAR,@piintIntervalRange)
				) = 0
			)
		)
		BEGIN
			SET @ErrMsg = 'Range Date Invalid'
			GOTO ExitSP	
		END
		
		--*
		UPDATE IT_ScheduleTask
		SET
			ScheduleType = @pivchScheduleType,
			ScheduleTitle = @pivchScheduleTitle,
			StartDate = @pidtmStartDate,
			EndDate = @pidtmEndDate,
			IntervalBy = @pivchIntervalBy,
			IntervalRange = @piintIntervalRange,
			IntervalHour = @pivchIntervalHour,
			IntervalMinute = @pivchIntervalMinute,
			Status = @pivchStatus,
			Description = @pivchDescription,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ScheduleNo = @pivchScheduleNo
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ScheduleTaskUpdate
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ScheduleTaskUpdate
	END
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spScheduleTaskView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spScheduleTaskView'
	DROP PROCEDURE [dbo].[spScheduleTaskView]
END
GO

PRINT 'CREATE PROCEDURE spScheduleTaskView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spScheduleTaskView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Schedule Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spScheduleTaskView		
	@pivchScheduleNo VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ScheduleNo,
		a.ScheduleType,
		a.ScheduleTitle,
		a.Description,
		a.StartDate,
		a.EndDate,
		a.IntervalBy,
		a.IntervalRange,
		a.IntervalHour,
		a.IntervalMinute,
		a.Status,
		a.created_date,
		a.created_by,
		b.UserName AS UserCreated,
		a.update_date,
		a.update_by,
		c.UserName AS UserUpdate
	FROM
		IT_ScheduleTask AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.created_by = b.UserId
		LEFT JOIN MsUsers AS c WITH(NOLOCK) ON
			a.update_by = c.UserId
	WHERE
		a.ScheduleNo = @pivchScheduleNo
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchInsert'
	DROP PROCEDURE [dbo].[spBranchInsert]
END
GO

PRINT 'CREATE PROCEDURE spBranchInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Insert Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchInsert
	@piintBranchId INT,
	@pivchBranchCode VARCHAR(20),
	@pivchBranchName VARCHAR(50),
	@piintBranchType INT,
	@piintBranchParent INT,
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsBranch WITH(NOLOCK) 
				WHERE BranchId = @piintBranchId 
					AND BranchCode =  @pivchBranchCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Branch Id or Branch Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsBranch (
				BranchId,
				BranchCode,
				BranchName,
				BranchType,
				BranchParent,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@piintBranchId, 
				@pivchBranchCode,
				@pivchBranchName,
				@piintBranchType,
				CASE 
					WHEN @piintBranchParent = 0 THEN NULL
					ELSE @piintBranchParent
				END,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN BranchInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchInsert
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchList'
	DROP PROCEDURE [dbo].[spBranchList]
END
GO

PRINT 'CREATE PROCEDURE spBranchList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.BranchId,
					a.BranchCode,
					a.BranchName,
					CASE a.BranchType
						WHEN ''1'' THEN ''BRANCH''
						ELSE ''SBP''
					END as BranchType,
					b.BranchName as BranchParent,
					a.IsActive
				FROM
					MsBranch a WITH(NOLOCK)
					LEFT JOIN MsBranch b WITH(NOLOCK) ON a.BranchParent = b.BranchId'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchUpdate'
	DROP PROCEDURE [dbo].[spBranchUpdate]
END
GO

PRINT 'CREATE PROCEDURE spBranchUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Update Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchUpdate
	@piintBranchId INT,
	@pivchBranchCode VARCHAR(20),
	@pivchBranchName VARCHAR(50),
	@piintBranchType INT,
	@piintBranchParent INT,
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN BranchUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsBranch
		SET
			BranchCode = @pivchBranchCode,
			BranchName = @pivchBranchName,
			BranchType = @piintBranchType,
			BranchParent = 
					CASE 
						WHEN @piintBranchParent = 0 THEN NULL
						ELSE @piintBranchParent
					END,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			BranchId = @piintBranchId
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN BranchUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN BranchUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBranchView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spBranchView'
	DROP PROCEDURE [dbo].[spBranchView]
END
GO

PRINT 'CREATE PROCEDURE spBranchView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spBranchView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Branch Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spBranchView		
	@piintBranchId INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		BranchId,
		BranchCode,
		BranchName,
		BranchType,
		BranchParent,
		IsActive
	FROM
		MsBranch WITH(NOLOCK)
	WHERE
		BranchId = @piintBranchId
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spConditionInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spConditionInsert'
	DROP PROCEDURE [dbo].[spConditionInsert]
END
GO

PRINT 'CREATE PROCEDURE spConditionInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spConditionInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Insert Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spConditionInsert
	@piintConditionCode INT,
	@pivchConditionName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ConditionInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsCondition WITH(NOLOCK) 
				WHERE ConditionCode =  @piintConditionCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Condition Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsCondition (
				ConditionCode,
				ConditionName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@piintConditionCode,
				@pivchConditionName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ConditionInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ConditionInsert
	END
END
GO

SET NOCOUNT OFF
GO     

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spConditionList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spConditionList'
	DROP PROCEDURE [dbo].[spConditionList]
END
GO

PRINT 'CREATE PROCEDURE spConditionList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spConditionList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Condition
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spConditionList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					ConditionCode,
					ConditionName,
					IsActive
				FROM
					MsCondition a WITH(NOLOCK) '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spConditionUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spConditionUpdate'
	DROP PROCEDURE [dbo].[spConditionUpdate]
END
GO

PRINT 'CREATE PROCEDURE spConditionUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spConditionUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Update Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spConditionUpdate
	@piintConditionCode INT,
    @pivchConditionName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ConditionUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsCondition
		SET
			ConditionCode = @piintConditionCode,
            ConditionName = @pivchConditionName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ConditionCode = @piintConditionCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ConditionUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ConditionUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spConditionView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spConditionView'
	DROP PROCEDURE [dbo].[spConditionView]
END
GO

PRINT 'CREATE PROCEDURE spConditionView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spConditionView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Condition Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spConditionView		
	@piintConditionCode INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		ConditionCode,
		ConditionName,
		IsActive
	FROM
		MsCondition WITH(NOLOCK)
	WHERE
		ConditionCode = @piintConditionCode
END
GO

SET NOCOUNT OFF
GO     

--**

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyInsert'
	DROP PROCEDURE [dbo].[spCurrencyInsert]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyInsert
	@pivchCurrencyCode VARCHAR(3),
	@pivchDescription VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN CurrencyInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsCurrency WITH(NOLOCK) 
				WHERE currency_code =  @pivchCurrencyCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Currency Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsCurrency (
				currency_code,
				description,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchCurrencyCode,
				@pivchDescription,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN CurrencyInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN CurrencyInsert
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyList'
	DROP PROCEDURE [dbo].[spCurrencyList]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					currency_code,
					description,
					IsActive
				FROM
					MsCurrency a WITH(NOLOCK) '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyUpdate'
	DROP PROCEDURE [dbo].[spCurrencyUpdate]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyUpdate
	@pivchCurrencyCode VARCHAR(3),
	@pivchDescription VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN CurrencyUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsCurrency
		SET
			currency_code = @pivchCurrencyCode,
			description = @pivchDescription,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			currency_code = @pivchCurrencyCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN CurrencyUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN CurrencyUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCurrencyView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spCurrencyView'
	DROP PROCEDURE [dbo].[spCurrencyView]
END
GO

PRINT 'CREATE PROCEDURE spCurrencyView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spCurrencyView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Currency Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spCurrencyView		
	@pivchCurrencyCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		currency_code,
		description,
		IsActive
	FROM
		MsCurrency WITH(NOLOCK)
	WHERE
		currency_code = @pivchCurrencyCode
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementInsert'
	DROP PROCEDURE [dbo].[spDepartementInsert]
END
GO

PRINT 'CREATE PROCEDURE spDepartementInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementInsert
	@pivchDepartementCode VARCHAR(2),
	@pivchDepartementName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN DepartementInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsDepartement WITH(NOLOCK) WHERE DepartementCode = @pivchDepartementCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Departement Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsDepartement (
				DepartementCode,
				DepartementName,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchDepartementCode,
				@pivchDepartementName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN DepartementInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN DepartementInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementList'
	DROP PROCEDURE [dbo].[spDepartementList]
END
GO

PRINT 'CREATE PROCEDURE spDepartementList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					DepartementCode,
					DepartementName,
					IsActive
				FROM
					MsDepartement WITH(NOLOCK)'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementUpdate'
	DROP PROCEDURE [dbo].[spDepartementUpdate]
END
GO

PRINT 'CREATE PROCEDURE spDepartementUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementUpdate
	@pivchDepartementCode VARCHAR(2),
	@pivchDepartementName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN DepartementUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsDepartement
		SET
			DepartementName = @pivchDepartementName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			DepartementCode = @pivchDepartementCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN DepartementUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN DepartementUpdate
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDepartementView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spDepartementView'
	DROP PROCEDURE [dbo].[spDepartementView]
END
GO

PRINT 'CREATE PROCEDURE spDepartementView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spDepartementView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spDepartementView		
	@pivchDepartementCode VARCHAR(2)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		DepartementCode,
		DepartementName,
		IsActive
	FROM
		MsDepartement WITH(NOLOCK)
	WHERE
		DepartementCode = @pivchDepartementCode
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemGroupInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemGroupInsert'
	DROP PROCEDURE [dbo].[spItemGroupInsert]
END
GO

PRINT 'CREATE PROCEDURE spItemGroupInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemGroupInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Insert Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemGroupInsert
	@pivchItemGroupCode VARCHAR(4),
	@pivchItemGroupName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemGroupInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsItemGroup WITH(NOLOCK) 
				WHERE item_group_code = @pivchItemGroupCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Group Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsItemGroup (
				item_group_code,
				item_group_name,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemGroupCode,
				@pivchItemGroupName,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ItemGroupInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemGroupInsert
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemGroupList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemGroupList'
	DROP PROCEDURE [dbo].[spItemGroupList]
END
GO

PRINT 'CREATE PROCEDURE spItemGroupList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemGroupList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemGroupList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					item_group_code,
					item_group_name,
					IsActive
				FROM
					MsItemGroup WITH(NOLOCK) '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemGroupUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemGroupUpdate'
	DROP PROCEDURE [dbo].[spItemGroupUpdate]
END
GO

PRINT 'CREATE PROCEDURE spItemGroupUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemGroupUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk Update Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemGroupUpdate
	@pivchItemGroupCode VARCHAR(4),
	@pivchItemGroupName VARCHAR(100),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemGroupUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsItemGroup
		SET
			item_group_code = @pivchItemGroupCode,
			item_group_name = @pivchItemGroupName,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			item_group_code = @pivchItemGroupCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemGroupUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemGroupUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemGroupView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemGroupView'
	DROP PROCEDURE [dbo].[spItemGroupView]
END
GO

PRINT 'CREATE PROCEDURE spItemGroupView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemGroupView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-20
**	Description		: SP untuk show Item Group Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemGroupView		
	@pivchItemGroupCode VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		item_group_code,
		item_group_name,
		IsActive
	FROM
		MsItemGroup WITH(NOLOCK)
	WHERE
		item_group_code = @pivchItemGroupCode
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemTypeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemTypeInsert'
	DROP PROCEDURE [dbo].[spItemTypeInsert]
END
GO

PRINT 'CREATE PROCEDURE spItemTypeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemTypeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Insert Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemTypeInsert
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(50),
	@pivchItemGroupCode VARCHAR(4),
	@pimonPrice MONEY,
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTypeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsItemType WITH(NOLOCK) 
				WHERE item_type_code = @pivchItemTypeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Item Type Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsItemType (
				item_type_code,
				item_type_name,
				item_group_code,
				price,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchItemTypeCode,
				@pivchItemTypeName,
				@pivchItemGroupCode,
				@pimonPrice,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN ItemTypeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTypeInsert
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemTypeList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemTypeList'
	DROP PROCEDURE [dbo].[spItemTypeList]
END
GO

PRINT 'CREATE PROCEDURE spItemTypeList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemTypeList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemTypeList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.item_type_code,
					a.item_type_name,
					a.item_group_code,
					b.item_group_name,
					a.category_code,
					a.price,
					a.IsActive
				FROM
					MsItemType a WITH(NOLOCK)
					INNER JOIN MsItemGroup b WITH(NOLOCK) ON a.item_group_code = b.item_group_code'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemTypeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemTypeUpdate'
	DROP PROCEDURE [dbo].[spItemTypeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spItemTypeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemTypeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk Update Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemTypeUpdate
	@pivchItemTypeCode VARCHAR(10),
	@pivchItemTypeName VARCHAR(50),
	@pivchItemGroupCode VARCHAR(4),
	@pimonPrice MONEY,
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemTypeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsItemType
		SET
			item_type_name = @pivchItemTypeName,
			item_group_code = @pivchItemGroupCode,
			price = @pimonPrice,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			item_type_code = @pivchItemTypeCode
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN ItemTypeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemTypeUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spItemTypeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spItemTypeView'
	DROP PROCEDURE [dbo].[spItemTypeView]
END
GO

PRINT 'CREATE PROCEDURE spItemTypeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spItemTypeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-06-11
**	Description		: SP untuk show Item Type Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spItemTypeView		
	@pivchItemTypeCode VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.item_type_code,
		a.item_type_name,
		a.item_group_code,
		b.item_group_name,
		a.Price,
		a.IsActive
	FROM
		MsItemType AS a WITH(NOLOCK)
		INNER JOIN MsItemGroup AS b WITH(NOLOCK) ON
			a.item_group_code = b.item_group_code
	WHERE
		a.item_type_code = @pivchItemTypeCode
END
GO

SET NOCOUNT OFF
GO     

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalDelete'
	DROP PROCEDURE [dbo].[spMappingApprovalDelete]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalDelete
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		-- Delete Email
		DELETE FROM
			MsMappingApprovalMail
		WHERE
			ApprovalID = @piintApprovalID
		
		IF @@ERROR <> 0
			GOTO ExitSP

		-- Delete Mapping
		DELETE FROM
			MsMappingApproval
		WHERE
			ApprovalID = @piintApprovalID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalDelete
	END
END
GO

SET NOCOUNT OFF
GO    

--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailDelete]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailDelete'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailDelete]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailDelete'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailDelete
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Delete Mapping Approval E-Mail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailDelete
	@piintApprovalEmailID INT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalEmailDelete
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		-- Delete Email
		DELETE FROM
			MsMappingApprovalMail
		WHERE
			ApprovalEmailID = @piintApprovalEmailID
		
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalEmailDelete
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalEmailDelete
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailInsert'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailInsert]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Mapping Approval E-Mail Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailInsert
	@piintApprovalID INT,
    @pivchUserIdEmail VARCHAR(50),
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalEmailInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		IF(
			EXISTS(
				SELECT ''
				FROM MsMappingApprovalMail WITH(NOLOCK)
				WHERE
					ApprovalID = @piintApprovalID
					AND UserEmail = @pivchUserIdEmail
			)
		)
		BEGIN
			SET @ErrMsg = 'User E-Mail already in list'
			GOTO ExitSP
		END
		
		INSERT INTO MsMappingApprovalMail (
			ApprovalID,
			UserEmail,
			created_date,
			created_by
		)
		SELECT
			@piintApprovalID,
			@pivchUserIdEmail,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalEmailInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalEmailInsert
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalEmailList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalEmailList'
	DROP PROCEDURE [dbo].[spMappingApprovalEmailList]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalEmailList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalEmailList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval E-Mail
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalEmailList		
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ApprovalEmailID,
		b.UserName,
		b.Email
	FROM
		MsMappingApprovalMail AS a WITH(NOLOCK)
		INNER JOIN MsUsers AS b WITH(NOLOCK) ON
			a.UserEmail = b.UserId
	WHERE
		a.ApprovalID = @piintApprovalID
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalInsert'
	DROP PROCEDURE [dbo].[spMappingApprovalInsert]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalInsert
	@piintMenuId INT,
    @pivchPrivilegeCode VARCHAR(5),
    @pivchParentCode VARCHAR(5),
    @pivchUserIdApproval VARCHAR(50),
    @piintBranchId INT,
    @piintState INT,
    @pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
			
		IF(
			EXISTS(
				SELECT ''
				FROM MsMappingApproval WITH(NOLOCK)
				WHERE
					MenuId = @piintMenuId
					AND PrivilegeCode = @pivchPrivilegeCode
					AND ParentCode = @pivchParentCode
					AND ISNULL(BranchId,0) = @piintBranchId
					AND State = @piintState
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Mapping Approval sudah ada dalam Database'
			GOTO ExitSP
		END
		
		INSERT INTO MsMappingApproval (
			MenuId,
			PrivilegeCode,
			ParentCode,
			UserIdApproval,
			BranchId,
			State,
			IsActive,
			created_date,
			created_by
		)
		SELECT
			@piintMenuId,
			@pivchPrivilegeCode,
			@pivchParentCode,
			CASE
				WHEN @pivchUserIdApproval = '' THEN NULL
				ELSE @pivchUserIdApproval
			END,
			CASE
				WHEN @piintBranchId = 0 THEN NULL
				ELSE @piintBranchId
			END,
			@piintState,
			@pibitIsActive,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalInsert
	END
END
GO

SET NOCOUNT OFF
GO   

--**
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalList'
	DROP PROCEDURE [dbo].[spMappingApprovalList]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.ApprovalID,
					a.MenuId,
					a.PrivilegeCode,
					c.PrivilegeName,
					a.ParentCode,
					d.PrivilegeName AS ParentName,
					a.UserIdApproval,
					f.UserName AS UserNameApproval,
					a.BranchId,
					a.State,
					a.IsActive,
					b.MenuName,
					e.BranchName
				FROM
					MsMappingApproval AS a WITH(NOLOCK)
					INNER JOIN MsMenu AS b WITH(NOLOCK) ON
						(a.MenuId = b.MenuId)
					INNER JOIN MsPrivilege AS c WITH(NOLOCK) ON
						(a.PrivilegeCode = c.PrivilegeCode)
					LEFT JOIN MsPrivilege AS d WITH(NOLOCK) ON
						(a.ParentCode = d.PrivilegeCode)
					LEFT JOIN MsBranch AS e WITH(NOLOCK) ON
						(a.BranchId = e.BranchId)
					LEFT JOIN MsUsers AS f WITH(NOLOCK) ON
						(a.UserIdApproval = f.UserId)'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy

	SET @sql = @sql + ' ORDER BY a.MenuId, a.State'
			
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalUpdate'
	DROP PROCEDURE [dbo].[spMappingApprovalUpdate]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalUpdate
	@piintApprovalId INT,
	@piintMenuId INT,
    @pivchPrivilegeCode VARCHAR(5),
    @pivchParentCode VARCHAR(5),
    @pivchUserIdApproval VARCHAR(50),
    @piintBranchId INT,
    @piintState INT,
    @pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM MsMappingApproval WITH(NOLOCK)
				WHERE
					MenuId = @piintMenuId
					AND PrivilegeCode = @pivchPrivilegeCode
					AND ParentCode = @pivchParentCode
					AND ISNULL(BranchId,0) = @piintBranchId
					AND State = @piintState
					AND ApprovalID <> @piintApprovalId
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Mapping Approval sudah ada dalam Database'
			GOTO ExitSP
		END
		
		UPDATE MsMappingApproval
		SET
			MenuId = @piintMenuId,
			PrivilegeCode = @pivchPrivilegeCode,
			ParentCode = @pivchParentCode,
			UserIdApproval = CASE
								WHEN @pivchUserIdApproval = '' THEN NULL
								ELSE @pivchUserIdApproval
							END,
			BranchId = CASE
							WHEN @piintBranchId = 0 THEN NULL
							ELSE @piintBranchId
						END,
			State = @piintState,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ApprovalID = @piintApprovalID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalUpdate
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalView'
	DROP PROCEDURE [dbo].[spMappingApprovalView]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalView
	@piintApprovalID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.ApprovalID,
		a.MenuId,
		b.MenuName,
		a.PrivilegeCode,
		c.PrivilegeName,
		a.ParentCode,
		d.PrivilegeName AS ParentName,
		a.UserIdApproval,
		f.UserName AS UserNameApproval,
		a.BranchId,
		e.BranchName,
		a.State,
		a.IsActive
	FROM
		MsMappingApproval AS a WITH(NOLOCK)
		INNER JOIN MsMenu AS b WITH(NOLOCK) ON
			(a.MenuId = b.MenuId)
		INNER JOIN MsPrivilege AS c WITH(NOLOCK) ON
			(a.PrivilegeCode = c.PrivilegeCode)
		LEFT JOIN MsPrivilege AS d WITH(NOLOCK) ON
			(a.ParentCode = d.PrivilegeCode)
		LEFT JOIN MsBranch AS e WITH(NOLOCK) ON
			(a.BranchId = e.BranchId)
		LEFT JOIN MsUsers AS f WITH(NOLOCK) ON
			(a.UserIdApproval = f.UserId)
	WHERE
		a.ApprovalID = @piintApprovalID
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementInsert'
	DROP PROCEDURE [dbo].[spMeasurementInsert]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Insert Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementInsert
	@pivchMeasurementCode VARCHAR(10),
	@pivchDescription VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MeasurementInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsMeasurement WITH(NOLOCK) 
				WHERE measurement_code =  @pivchMeasurementCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Measurement Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsMeasurement (
				measurement_code,
				description,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchMeasurementCode,
				@pivchDescription,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN MeasurementInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MeasurementInsert
	END
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementList'
	DROP PROCEDURE [dbo].[spMeasurementList]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					measurement_code,
					description,
					IsActive
				FROM
					MsMeasurement a WITH(NOLOCK) '
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementUpdate'
	DROP PROCEDURE [dbo].[spMeasurementUpdate]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk Update Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementUpdate
	@pivchMeasurementCode VARCHAR(10),
	@pivchDescription VARCHAR(20),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MeasurementUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsMeasurement
		SET
			measurement_code = @pivchMeasurementCode,
			description = @pivchDescription,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			measurement_code = @pivchMeasurementCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MeasurementUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MeasurementUpdate
	END
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMeasurementView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMeasurementView'
	DROP PROCEDURE [dbo].[spMeasurementView]
END
GO

PRINT 'CREATE PROCEDURE spMeasurementView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMeasurementView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-06-12
**	Description		: SP untuk show Measurement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMeasurementView		
	@pivchMeasurementCode VARCHAR(3)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		measurement_code,
		description,
		IsActive
	FROM
		MsMeasurement WITH(NOLOCK)
	WHERE
		measurement_code = @pivchMeasurementCode
END
GO

SET NOCOUNT OFF
GO      

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeInsert'
	DROP PROCEDURE [dbo].[spPrivilegeInsert]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeInsert
	@pivchPrivilegeCode VARCHAR(4),
	@pivchPrivilegeName VARCHAR(100),
	@pivchDepartementCode VARCHAR(2),
	@pivchOldCode VARCHAR(5),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsPrivilege WITH(NOLOCK) WHERE PrivilegeCode = @pivchPrivilegeCode
			)
		)
		BEGIN
			SET @ErrMsg = 'Privilege Code already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsPrivilege (
				PrivilegeCode,
				PrivilegeName,
				DepartementCode,
				OldCode,
				IsActive,
				created_date,
				created_by
			)
			SELECT
				@pivchPrivilegeCode,
				@pivchPrivilegeName,
				@pivchDepartementCode,
				@pivchOldCode,
				@pibitIsActive,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN PrivilegeInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeInsert
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeList'
	DROP PROCEDURE [dbo].[spPrivilegeList]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.PrivilegeCode,
					a.PrivilegeName,
					b.DepartementCode,
					b.DepartementName,
					a.IsActive
				FROM
					MsPrivilege AS a WITH(NOLOCK)
					INNER JOIN MsDepartement AS b WITH(NOLOCK) ON
						a.DepartementCode = b.DepartementCode'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO   

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuClear]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuClear'
	DROP PROCEDURE [dbo].[spPrivilegeMenuClear]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuClear'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuClear
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Clear Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuClear
	@pivchPrivilegeCode VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeMenuClear
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM MsPrivilegeDt
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeMenuClear
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeMenuClear
	END
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuList'
	DROP PROCEDURE [dbo].[spPrivilegeMenuList]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Privilege Menu Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuList		
	@pivchPrivilegeCode VARCHAR(4),
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.MenuId,
					a.MenuName,
					a.MenuParent,'

	IF (@pivchPrivilegeCode = '') AND (@pivchUserId = '')
	BEGIN
		SET @sql = @sql + '
					CONVERT(BIT,0) AS InsertDt,
					CONVERT(BIT,0) AS UpdateDt,
					CONVERT(BIT,0) AS DeleteDt,
					CONVERT(BIT,0) AS ViewDt'
	END
	ELSE
	BEGIN
		SET @sql = @sql + '
					CONVERT(BIT,ISNULL(b.InsertDt,0)) AS InsertDt,
					CONVERT(BIT,ISNULL(b.UpdateDt,0)) AS UpdateDt,
					CONVERT(BIT,ISNULL(b.DeleteDt,0)) AS DeleteDt,
					CONVERT(BIT,ISNULL(b.ViewDt,0)) AS ViewDt'
	END
	
	SET @sql = @sql + '
				FROM
					MsMenu AS a WITH(NOLOCK)'
					
	IF (@pivchPrivilegeCode <> '')
	BEGIN
		SET @sql = @sql + '
					LEFT JOIN MsPrivilegeDt AS b WITH(NOLOCK) ON
						a.MenuId = b.MenuId
						AND b.PrivilegeCode = ''' + @pivchPrivilegeCode + ''''
	END
	ELSE IF (@pivchUserId <> '')
	BEGIN
		SET @sql = @sql + '
					LEFT JOIN MsUserMenu AS b WITH(NOLOCK) ON
						a.MenuId = b.MenuId
						AND b.UserId = ''' + @pivchUserId + ''''
	END
				
	SET @sql = @sql + '				
				WHERE
					a.IsActive = 1
				ORDER BY
					a.MenuId'
					
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeMenuUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeMenuUpdate'
	DROP PROCEDURE [dbo].[spPrivilegeMenuUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeMenuUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeMenuUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeMenuUpdate
	@pivchPrivilegeCode VARCHAR(4),
	@piintMenuId INT,
	@pibitInsert BIT,
	@pibitUpdate BIT,
	@pibitDelete BIT,
	@pibitView BIT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeMenuUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		-- Delete First, then Insert
		DELETE FROM MsPrivilegeDt
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
			AND MenuId = @piintMenuId
		
		IF @@ERROR <> 0
			GOTO ExitSP
		
		IF
			(@pibitInsert = 1)
			OR (@pibitUpdate = 1)
			OR (@pibitDelete = 1)
			OR (@pibitView = 1)
		BEGIN
			INSERT INTO MsPrivilegeDt (
				PrivilegeCode,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			)
			SELECT
				@pivchPrivilegeCode,
				@piintMenuId,
				@pibitInsert,
				@pibitUpdate,
				@pibitDelete,
				@pibitView
		END
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeMenuUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeMenuUpdate
	END
END
GO

SET NOCOUNT OFF
GO

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeUpdate'
	DROP PROCEDURE [dbo].[spPrivilegeUpdate]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeUpdate
	@pivchPrivilegeCode VARCHAR(4),
	@pivchPrivilegeName VARCHAR(100),
	@pivchDepartementCode VARCHAR(2),
	@pivchOldCode VARCHAR(5),
	@pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PrivilegeUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsPrivilege
		SET
			PrivilegeName = @pivchPrivilegeName,
			DepartementCode = @pivchDepartementCode,
			OldCode = @pivchOldCode,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			PrivilegeCode = @pivchPrivilegeCode
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN PrivilegeUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PrivilegeUpdate
	END
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPrivilegeView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spPrivilegeView'
	DROP PROCEDURE [dbo].[spPrivilegeView]
END
GO

PRINT 'CREATE PROCEDURE spPrivilegeView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spPrivilegeView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Departement Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spPrivilegeView		
	@pivchPrivilegeCode VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		a.PrivilegeCode,
		a.PrivilegeName,
		a.DepartementCode,
		b.DepartementName,
		a.OldCode,
		a.IsActive
	FROM
		MsPrivilege AS a WITH(NOLOCK)
		INNER JOIN MsDepartement AS b WITH(NOLOCK) ON
			a.DepartementCode = b.DepartementCode
	WHERE
		a.PrivilegeCode = @pivchPrivilegeCode
END
GO

SET NOCOUNT OFF
GO    

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersChangePassword]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersChangePassword'
	DROP PROCEDURE [dbo].[spUsersChangePassword]
END
GO

PRINT 'CREATE PROCEDURE spUsersChangePassword'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersChangePassword / MsChangePassword
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-16
**	Description		: SP untuk Change Password User Logon
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersChangePassword
	@UserId VARCHAR(50),
	@Pass VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersChangePassword
		DECLARE
			@ErrMsg VARCHAR(2000)
	
		UPDATE
			MsUsers
		SET
			Pass = @Pass,
			ChangePass = 'N' 
		WHERE
			UserId = @UserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
	COMMIT TRAN UsersChangePassword
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersChangePassword
	END
END
GO

SET NOCOUNT OFF
GO         

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersInsert'
	DROP PROCEDURE [dbo].[spUsersInsert]
END
GO

PRINT 'CREATE PROCEDURE spUsersInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersInsert
	@pivchUserId VARCHAR(50),
    @pivchUserName VARCHAR(100),
    @piintBranchId INT,
    @pivchEmail VARCHAR(50),
    @pivchPass VARCHAR(100),
    @pivchCanSendEmail VARCHAR(1),
    @pivchCanChangePass VARCHAR(1),
    @pivchPrivilegeCode VARCHAR(4),
    @pibitIsActive BIT,
    @pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF (
			EXISTS (
				SELECT '' FROM MsUsers WITH(NOLOCK) WHERE UserId = @pivchUserId
			)
		)
		BEGIN
			SET @ErrMsg = 'User ID already in database'
			GOTO ExitSP
		END
		ELSE
		BEGIN
			INSERT INTO MsUsers (
				UserId,
				UserName,
				BranchId,
				Email,
				Pass,
				CanSendMail,
				ChangePass,
				IsActive,
				PrivilegeCode,
				created_date,
				created_by
			)
			SELECT
				@pivchUserId,
				@pivchUserName,
				@piintBranchId,
				@pivchEmail,
				@pivchPass,
				@pivchCanSendEmail,
				@pivchCanChangePass,
				@pibitIsActive,
				@pivchPrivilegeCode,
				GETDATE(),
				@pivchInputID
		
			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN UsersInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersInsert
	END
END
GO

SET NOCOUNT OFF
GO    
   
--**
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersList]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersList'
	DROP PROCEDURE [dbo].[spUsersList]
END
GO

PRINT 'CREATE PROCEDURE spUsersList'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersList
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersList		
	@pivchWhereBy VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @sql VARCHAR(2000)
	
	SET @sql = 'SELECT
					a.UserId,
					a.Pass,
					a.UserName,
					a.UgetsValue,
					a.BranchId,
					a.GroupId,
					a.PriviledgeCode,
					a.PrivilegeCode,
					a.IsActive,
					a.CanEditOpex,
					a.Email,
					a.CanSendMail,
					a.ChangePass,
					b.BranchName
				FROM
					MsUsers AS a WITH(NOLOCK)
					INNER JOIN MsBranch AS b WITH(NOLOCK) ON (a.BranchId = b.BranchId)'
	
	IF (@pivchWhereBy <> '')
		SET @sql = @sql + ' WHERE ' + @pivchWhereBy
		
	SET @sql = @sql + ' ORDER BY a.UserId'
		
	PRINT @sql
	EXEC(@sql)
END
GO

SET NOCOUNT OFF
GO  

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersMenuClear]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersMenuClear'
	DROP PROCEDURE [dbo].[spUsersMenuClear]
END
GO

PRINT 'CREATE PROCEDURE spUsersMenuClear'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersMenuClear
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Clear Users Menu Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersMenuClear
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersMenuClear
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		DELETE FROM MsUserMenu
		WHERE
			UserId = @pivchUserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN UsersMenuClear
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersMenuClear
	END
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersMenuUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersMenuUpdate'
	DROP PROCEDURE [dbo].[spUsersMenuUpdate]
END
GO

PRINT 'CREATE PROCEDURE spUsersMenuUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersMenuUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Privilege Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersMenuUpdate
	@pivchUserId VARCHAR(50),
	@piintMenuId INT,
	@pibitInsert BIT,
	@pibitUpdate BIT,
	@pibitDelete BIT,
	@pibitView BIT
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersMenuUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		-- Delete first, then insert
		DELETE FROM MsUserMenu
		WHERE
			UserId = @pivchUserId
			AND MenuId = @piintMenuId
			
		IF @@ERROR <> 0
			GOTO ExitSP
			
		IF
			(@pibitInsert = 1)
			OR (@pibitUpdate = 1)
			OR (@pibitDelete = 1)
			OR (@pibitView = 1)
		BEGIN
			INSERT INTO MsUserMenu (
				UserId,
				MenuId,
				InsertDt,
				UpdateDt,
				DeleteDt,
				ViewDt
			)
			SELECT
				@pivchUserId,
				@piintMenuId,
				@pibitInsert,
				@pibitUpdate,
				@pibitDelete,
				@pibitView
		END
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN UsersMenuUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersMenuUpdate
	END
END
GO

SET NOCOUNT OFF
GO 

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersUpdate'
	DROP PROCEDURE [dbo].[spUsersUpdate]
END
GO

PRINT 'CREATE PROCEDURE spUsersUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersUpdate
	@pivchUserId VARCHAR(50),
    @pivchUserName VARCHAR(100),
    @piintBranchId INT,
    @pivchEmail VARCHAR(50),
    @pivchPass VARCHAR(100),
    @pivchCanSendEmail VARCHAR(1),
    @pivchCanChangePass VARCHAR(1),
    @pivchPrivilegeCode VARCHAR(4),
    @pibitIsActive BIT,
    @pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN UsersInsert
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		UPDATE MsUsers
		SET
			UserName = @pivchUserName,
			BranchId = @piintBranchId,
			Email = @pivchEmail,
			CanSendMail = @pivchCanSendEmail,
			ChangePass = @pivchCanChangePass,
			IsActive = @pibitIsActive,
			PrivilegeCode = @pivchPrivilegeCode,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			UserId = @pivchUserId
	
		IF @@ERROR <> 0
			GOTO ExitSP
		
		-- Update Password
		IF @pivchPass <> ''
		BEGIN
			UPDATE MsUsers
			SET
				Pass = @pivchPass
			WHERE
				UserId = @pivchUserId

			IF @@ERROR <> 0
				GOTO ExitSP
		END
		
	COMMIT TRAN UsersInsert
	RETURN
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN UsersInsert
	END
END
GO

SET NOCOUNT OFF
GO     

--**
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUsersView]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spUsersView'
	DROP PROCEDURE [dbo].[spUsersView]
END
GO

PRINT 'CREATE PROCEDURE spUsersView'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spUsersView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk show Users Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spUsersView		
	@pivchUserId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		UserId,
		UserName,
		BranchId,
		IsActive,
		Email,
		CanSendMail,
		ChangePass,
		PrivilegeCode
	FROM
		MsUsers WITH(NOLOCK)
	WHERE
		UserId = @pivchUserId
END
GO

SET NOCOUNT OFF
GO    

--**

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwMsMenu]'))
BEGIN
	PRINT 'DROP VIEW vwMsMenu'
	DROP VIEW [dbo].[vwMsMenu]
END
GO

PRINT 'CREATE VIEW vwMsMenu'
GO

/*---------------------------------------------------------------------------
**	View Name		: vwMsMenu / MsMenuView
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: arie
**	Created Date	: 2013-05-16
**	Description		: View untuk Data Menu
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE VIEW vwMsMenu
AS
	SELECT
		UM.UserId,
		UM.MenuId,
		MM.MenuName,
		MM.MenuParent,
		MM.MenuLink,
		MM.IsActive,
		UM.InsertDt,
		UM.UpdateDt,
		UM.DeleteDt,
		UM.ViewDt,
		MM.ReportId,
		MM.Parameter
	FROM
		dbo.MsUserMenu AS UM WITH (nolock)
		INNER JOIN dbo.MsMenu AS MM WITH (nolock) ON
			UM.MenuId = MM.MenuId
GO

COMMIT TRAN ScriptOperation