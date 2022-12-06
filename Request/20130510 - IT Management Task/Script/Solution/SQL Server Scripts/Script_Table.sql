USE [USOFT_UAT]
GO

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
COMMIT
GO

BEGIN TRAN ScriptTable123

--** MsBranch
PRINT 'CREATE TABLE MsBranch'
GO
ALTER TABLE dbo.MsBranch
	DROP CONSTRAINT DF_MsBranch_Status
GO
ALTER TABLE dbo.MsBranch
	DROP CONSTRAINT DF_MsBranch_CreatedDate
GO
CREATE TABLE dbo.Tmp_MsBranch
	(
	BranchId int NOT NULL,
	BranchCode varchar(20) NOT NULL,
	BranchName varchar(50) NOT NULL,
	BranchType int NOT NULL,
	BranchParent int NULL,
	IsActive bit NOT NULL,
	created_date datetime NOT NULL,
	created_by varchar(50) NOT NULL,
	update_date datetime NULL,
	update_by varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_MsBranch ADD CONSTRAINT
	DF_MsBranch_IsActive DEFAULT ((1)) FOR IsActive
GO
ALTER TABLE dbo.Tmp_MsBranch ADD CONSTRAINT
	DF_MsBranch_created_date DEFAULT (getdate()) FOR created_date
GO
IF EXISTS(SELECT * FROM dbo.MsBranch)
	 EXEC('INSERT INTO dbo.Tmp_MsBranch (BranchId, BranchCode, BranchName, BranchType, BranchParent, created_date, created_by)
		SELECT BranchId, BranchCode, BranchName, CASE WHEN BranchType = ''BRANCH'' THEN 1 ELSE NULL END, BranchParent, CreatedDate, CreateBy FROM dbo.MsBranch WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.MsBranch
GO
EXECUTE sp_rename N'dbo.Tmp_MsBranch', N'MsBranch', 'OBJECT' 
GO
ALTER TABLE dbo.MsBranch ADD CONSTRAINT
	PK_MsBranch PRIMARY KEY CLUSTERED 
	(
	BranchId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO


--** MsUsers
PRINT 'CREATE TABLE MsUsers'
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_AFUsers_UgetsValue
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_AFUsers_Active
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_AFUsers_CreateDate
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_AFUsers_CanEditOpex
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_MsUsers_CanSendMail
GO
ALTER TABLE dbo.MsUsers
	DROP CONSTRAINT DF_MsUsers_ChangePass
GO
CREATE TABLE dbo.Tmp_MsUsers
	(
	UserId varchar(50) NOT NULL,
	Pass varchar(100) NULL,
	UserName varchar(100) NULL,
	UgetsValue smallint NOT NULL,
	BranchId int NOT NULL,
	GroupId varchar(5) NULL,
	PriviledgeCode varchar(5) NULL,
	PrivilegeCode varchar(4) NULL,
	IsActive bit NOT NULL,
	CanEditOpex varchar(1) NOT NULL,
	Email nvarchar(50) NULL,
	CanSendMail varchar(1) NOT NULL,
	ChangePass varchar(1) NOT NULL,
	created_date datetime NOT NULL,
	created_by varchar(10) NOT NULL,
	update_date datetime NULL,
	update_by varchar(10) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_MsUsers ADD CONSTRAINT
	DF_AFUsers_UgetsValue DEFAULT ((1)) FOR UgetsValue
GO
ALTER TABLE dbo.Tmp_MsUsers ADD CONSTRAINT
	DF_AFUsers_Active DEFAULT ((1)) FOR IsActive
GO
ALTER TABLE dbo.Tmp_MsUsers ADD CONSTRAINT
	DF_AFUsers_CanEditOpex DEFAULT ('N') FOR CanEditOpex
GO
ALTER TABLE dbo.Tmp_MsUsers ADD CONSTRAINT
	DF_MsUsers_CanSendMail DEFAULT ('N') FOR CanSendMail
GO
ALTER TABLE dbo.Tmp_MsUsers ADD CONSTRAINT
	DF_MsUsers_ChangePass DEFAULT ('N') FOR ChangePass
GO
IF EXISTS(SELECT * FROM dbo.MsUsers)
	 EXEC('INSERT INTO dbo.Tmp_MsUsers (UserId, Pass, UserName, UgetsValue, BranchId, GroupId, PriviledgeCode, IsActive, CanEditOpex, Email, CanSendMail, ChangePass, created_date, created_by)
		SELECT UserId, Pass, UserName, UgetsValue, BranchId, GroupId, PriviledgeCode, CONVERT(bit, Active), CanEditOpex, Email, CanSendMail, ChangePass, CreateDate, ''arie'' FROM dbo.MsUsers WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.MsUsers
GO
EXECUTE sp_rename N'dbo.Tmp_MsUsers', N'MsUsers', 'OBJECT' 
GO
ALTER TABLE dbo.MsUsers ADD CONSTRAINT
	PK_AFUsers PRIMARY KEY CLUSTERED 
	(
	UserId
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO


--** MsMenu
PRINT 'CREATE TABLE MsMenu'
GO
ALTER TABLE dbo.MsMenu
	DROP CONSTRAINT DF_AFMenu_MenuActive
GO
CREATE TABLE dbo.Tmp_MsMenu
	(
	MenuId int NOT NULL,
	MenuName varchar(50) NOT NULL,
	MenuParent int NOT NULL,
	MenuLink varchar(100) NULL,
	IsActive bit NOT NULL,
	ReportId varchar(50) NULL,
	Parameter varchar(100) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_MsMenu ADD CONSTRAINT
	DF_AFMenu_MenuActive DEFAULT ((1)) FOR IsActive
GO
IF EXISTS(SELECT * FROM dbo.MsMenu)
	 EXEC('INSERT INTO dbo.Tmp_MsMenu (MenuId, MenuName, MenuParent, MenuLink, IsActive, ReportId, Parameter)
		SELECT MenuId, MenuName, MenuParent, MenuLink, CASE WHEN MenuActive = ''Y'' THEN 1 ELSE 0 END, ReportId, Parameter FROM dbo.MsMenu WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.MsMenu
GO
EXECUTE sp_rename N'dbo.Tmp_MsMenu', N'MsMenu', 'OBJECT' 
GO
ALTER TABLE dbo.MsMenu ADD CONSTRAINT
	PK_AFMenu PRIMARY KEY CLUSTERED 
	(
	MenuId
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

--** MsMappingUsers
PRINT 'CREATE TABLE MsMappingUsers'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingUsers_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingUsers]'))
	ALTER TABLE [dbo].[MsMappingUsers] DROP CONSTRAINT [FK_MsMappingUsers_MsUsers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingUsers]') AND type in (N'U'))
	DROP TABLE [dbo].[MsMappingUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsMappingUsers](
	[State] [int] NOT NULL,
	[UserId] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MsMappingUsers] PRIMARY KEY CLUSTERED 
(
	[State] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingUsers_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingUsers]'))
	ALTER TABLE [dbo].[MsMappingUsers]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingUsers_MsUsers] FOREIGN KEY([UserId])
	REFERENCES [dbo].[MsUsers] ([UserId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingUsers_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingUsers]'))
	ALTER TABLE [dbo].[MsMappingUsers] CHECK CONSTRAINT [FK_MsMappingUsers_MsUsers]
GO


--** MsPrivilege
PRINT 'CREATE TABLE MsPrivilege'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilege_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilege]'))
	ALTER TABLE [dbo].[MsPrivilege] DROP CONSTRAINT [FK_MsPrivilege_MsDepartement]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsPrivilege]') AND type in (N'U'))
	DROP TABLE [dbo].[MsPrivilege]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsPrivilege]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsPrivilege](
	[PrivilegeCode] [varchar](4) NOT NULL,
	[PrivilegeName] [varchar](100) NOT NULL,
	[DepartementCode] [varchar](2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[OldCode] [varchar](5) NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](10) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](10) NULL,
 CONSTRAINT [PK_MsPrivilege] PRIMARY KEY CLUSTERED 
(
	[PrivilegeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsPrivilegeDt
PRINT 'CREATE TABLE MsPrivilegeDt'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt] DROP CONSTRAINT [FK_MsPrivilegeDt_MsPrivilege]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt] DROP CONSTRAINT [FK_MsPrivilegeDt_MsMenu]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]') AND type in (N'U'))
DROP TABLE [dbo].[MsPrivilegeDt]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsPrivilegeDt](
	[PrivilegeCode] [varchar](4) NOT NULL,
	[MenuId] [int] NOT NULL,
	[InsertDt] [bit] NOT NULL,
	[UpdateDt] [bit] NOT NULL,
	[DeleteDt] [bit] NOT NULL,
	[ViewDt] [bit] NOT NULL,
 CONSTRAINT [PK_MsPrivilegeDt_1] PRIMARY KEY CLUSTERED 
(
	[PrivilegeCode] ASC,
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsDepartement
PRINT 'CREATE TABLE MsDepartement'
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsDepartement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsDepartement](
	[DepartementCode] [varchar](2) NOT NULL,
	[DepartementName] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](10) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](10) NULL,
 CONSTRAINT [PK_MsDepartement] PRIMARY KEY CLUSTERED 
(
	[DepartementCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

--** MsItemGroup
PRINT 'CREATE TABLE MsItemGroup'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsItemGroup]') AND type in (N'U'))
DROP TABLE [dbo].[MsItemGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsItemGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsItemGroup](
	[item_group_code] [varchar](4) NOT NULL,
	[item_group_name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](20) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](20) NULL,
 CONSTRAINT [PK_MsItemGroup] PRIMARY KEY CLUSTERED 
(
	[item_group_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsItemType
PRINT 'CREATE TABLE MsItemType'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsItem_MsItemGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsItemType]'))
ALTER TABLE [dbo].[MsItemType] DROP CONSTRAINT [FK_MsItem_MsItemGroup]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsItemType]') AND type in (N'U'))
DROP TABLE [dbo].[MsItemType]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsItemType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsItemType](
	[item_type_code] [varchar](10) NOT NULL,
	[item_type_name] [varchar](50) NOT NULL,
	[item_group_code] [varchar](4) NOT NULL,
	[category_code] [varchar](5) NULL,
	[price] [money] NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](20) NULL,
 CONSTRAINT [pk_msitem] PRIMARY KEY CLUSTERED 
(
	[item_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsMappingApproval
PRINT 'CREATE TABLE MsMappingApproval'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] DROP CONSTRAINT [FK_MsMappingApproval_MsUsers]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege1]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] DROP CONSTRAINT [FK_MsMappingApproval_MsPrivilege1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] DROP CONSTRAINT [FK_MsMappingApproval_MsPrivilege]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] DROP CONSTRAINT [FK_MsMappingApproval_MsMenu]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] DROP CONSTRAINT [FK_MsMappingApproval_MsBranch]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]') AND type in (N'U'))
DROP TABLE [dbo].[MsMappingApproval]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsMappingApproval](
	[ApprovalID] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[PrivilegeCode] [varchar](4) NOT NULL,
	[ParentCode] [varchar](4) NULL,
	[UserIdApproval] [varchar](50) NULL,
	[BranchId] [int] NULL,
	[State] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](10) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](10) NULL,
 CONSTRAINT [PK_MsMappingApproval] PRIMARY KEY CLUSTERED 
(
	[ApprovalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsMappingApprovalMail
PRINT 'CREATE TABLE MsMappingApprovalMail'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail] DROP CONSTRAINT [FK_MsMappingApprovalMail_MsUsers]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsMappingApproval]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail] DROP CONSTRAINT [FK_MsMappingApprovalMail_MsMappingApproval]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]') AND type in (N'U'))
DROP TABLE [dbo].[MsMappingApprovalMail]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsMappingApprovalMail](
	[ApprovalEmailID] [int] IDENTITY(1,1) NOT NULL,
	[ApprovalID] [int] NOT NULL,
	[UserEmail] [varchar](50) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MsMappingApprovalMail] PRIMARY KEY CLUSTERED 
(
	[ApprovalEmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsMenuSearch
PRINT 'CREATE TABLE MsMenuSearch'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMenuSearch_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]'))
ALTER TABLE [dbo].[MsMenuSearch] DROP CONSTRAINT [FK_MsMenuSearch_MsMenu]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]') AND type in (N'U'))
DROP TABLE [dbo].[MsMenuSearch]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsMenuSearch](
	[MenuId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[ParamName] [varchar](50) NULL,
	[ParamField] [varchar](255) NULL,
	[ParamType] [varchar](3) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MsMenuSearch] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC,
	[SequenceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** MsCondition
PRINT 'CREATE TABLE MsCondition'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsCondition]') AND type in (N'U'))
DROP TABLE [dbo].[MsCondition]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsCondition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsCondition](
	[ConditionCode] [int] NOT NULL,
	[ConditionName] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_MsCondition] PRIMARY KEY CLUSTERED 
(
	[ConditionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** IT_ActivityAssign
PRINT 'CREATE TABLE IT_ActivityAssign'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] DROP CONSTRAINT [FK_IT_ActivityAssign_MsUsers1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] DROP CONSTRAINT [FK_IT_ActivityAssign_MsUsers]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_IT_ActivityTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] DROP CONSTRAINT [FK_IT_ActivityAssign_IT_ActivityTask]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ActivityAssign]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ActivityAssign](
	[AssignID] [int] IDENTITY(1,1) NOT NULL,
	[ActivityNo] [varchar](12) NOT NULL,
	[AssignTo] [varchar](50) NULL,
	[AssignFrom] [varchar](50) NOT NULL,
	[DateAssign] [datetime] NOT NULL,
	[StatusAssign] [varchar](1) NULL,
	[Description] [varchar](255) NULL,
	[ReAssignID] [int] NULL,
 CONSTRAINT [PK_IT_ActivityAssign] PRIMARY KEY CLUSTERED 
(
	[AssignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_ActivityTask
PRINT 'CREATE TABLE IT_ActivityTask'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] DROP CONSTRAINT [FK_IT_ActivityTask_MsItemType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] DROP CONSTRAINT [FK_IT_ActivityTask_MsDepartement]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] DROP CONSTRAINT [FK_IT_ActivityTask_MsBranch]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ActivityTask]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ActivityTask](
	[ActivityNo] [varchar](12) NOT NULL,
	[ActivityDate] [datetime] NOT NULL,
	[item_type_code] [varchar](10) NOT NULL,
	[Quantity] [int] NULL,
	[BranchId] [int] NOT NULL,
	[RequestBy] [varchar](100) NOT NULL,
	[DepartementCode] [varchar](2) NULL,
	[Description] [varchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[Status] [varchar](1) NOT NULL,
	[Priority] [varchar](1) NOT NULL,
	[ApprovalState] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ActivityTask] PRIMARY KEY CLUSTERED 
(
	[ActivityNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** IT_DomainServer
PRINT 'CREATE TABLE IT_DomainServer'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_DomainServer]') AND type in (N'U'))
DROP TABLE [dbo].[IT_DomainServer]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_DomainServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_DomainServer](
	[Branch_Code] [varchar](5) NOT NULL,
	[Branch_Name] [varchar](100) NOT NULL,
	[Branch_IP] [varchar](15) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[created_date] [datetime] NULL,
	[created_by] [varchar](50) NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_it_domain_server] PRIMARY KEY CLUSTERED 
(
	[Branch_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_Item
PRINT 'CREATE TABLE IT_Item'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_MsPrivilege]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_MsItemType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_MsCondition]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_MsBranch]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemTransDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_IT_ItemTransDtl]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemInDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [FK_IT_Item_IT_ItemInDtl]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_Item_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_Item] DROP CONSTRAINT [DF_IT_Item_IsActive]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_Item]') AND type in (N'U'))
DROP TABLE [dbo].[IT_Item]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_Item](
	[ITItemCode] [varchar](10) NOT NULL,
	[ITItemInDtlCode] [varchar](10) NOT NULL,
	[ITItemTransDtlCode] [varchar](10) NULL,
	[ITItemOutCode] [varchar](8) NULL,
	[item_type_code] [varchar](10) NOT NULL,
	[SerialNo] [varchar](50) NULL,
	[Barcode] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[ParentCode] [varchar](10) NULL,
	[ConditionCode] [int] NOT NULL,
	[BranchId] [int] NULL,
	[UsedBy] [varchar](20) NULL,
	[PrivilegeCode] [varchar](4) NULL,
	[IsActive] [bit] NOT NULL,
	[StatusOut] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_Item] PRIMARY KEY CLUSTERED 
(
	[ITItemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_Item_History
PRINT 'CREATE TABLE IT_Item_History'
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_Item_History_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_Item_History] DROP CONSTRAINT [DF_IT_Item_History_IsActive]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_Item_History]') AND type in (N'U'))
DROP TABLE [dbo].[IT_Item_History]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_Item_History]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_Item_History](
	[ITItemCode] [varchar](10) NOT NULL,
	[ITItemInDtlCode] [varchar](10) NOT NULL,
	[ITItemTransDtlCode] [varchar](10) NULL,
	[ITItemOutCode] [varchar](8) NULL,
	[item_type_code] [varchar](10) NOT NULL,
	[SerialNo] [varchar](50) NULL,
	[Barcode] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[ParentCode] [varchar](10) NULL,
	[ConditionCode] [int] NOT NULL,
	[BranchId] [int] NULL,
	[UsedBy] [nchar](10) NULL,
	[PrivilegeCode] [varchar](4) NULL,
	[IsActive] [bit] NOT NULL,
	[StatusOut] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL
) ON [PRIMARY]
END
GO



--** IT_ItemIn
PRINT 'CREATE TABLE IT_ItemIn'
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_ItemIn_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_ItemIn] DROP CONSTRAINT [DF_IT_ItemIn_Status]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemIn]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ItemIn]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemIn]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ItemIn](
	[ITItemInCode] [varchar](8) NOT NULL,
	[Date] [datetime] NULL,
	[BranchId] [int] NULL,
	[ReceiveFrom] [varchar](50) NULL,
	[PIC] [varchar](20) NOT NULL,
	[Status] [varchar](1) NOT NULL,
	[ApprovalState] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ItemIn] PRIMARY KEY CLUSTERED 
(
	[ITItemInCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_ItemInDtl
PRINT 'CREATE TABLE IT_ItemInDtl'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] DROP CONSTRAINT [FK_IT_ItemInDtl_MsItemType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] DROP CONSTRAINT [FK_IT_ItemInDtl_MsCondition]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_IT_ItemIn]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] DROP CONSTRAINT [FK_IT_ItemInDtl_IT_ItemIn]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ItemInDtl]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ItemInDtl](
	[ITItemInDtlCode] [varchar](10) NOT NULL,
	[ITItemInCode] [varchar](8) NOT NULL,
	[item_type_code] [varchar](10) NOT NULL,
	[SerialNo] [varchar](50) NULL,
	[Barcode] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[ParentCode] [varchar](12) NULL,
	[ConditionCode] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ItemInDtl_1] PRIMARY KEY CLUSTERED 
(
	[ITItemInDtlCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--** IT_ItemOut
PRINT 'CREATE TABLE IT_ItemOut'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] DROP CONSTRAINT [FK_IT_ItemOut_MsCondition1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] DROP CONSTRAINT [FK_IT_ItemOut_MsCondition]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] DROP CONSTRAINT [FK_IT_ItemOut_MsBranch]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] DROP CONSTRAINT [FK_IT_ItemOut_IT_Item]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ItemOut]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ItemOut](
	[ITItemOutCode] [varchar](8) NOT NULL,
	[ITItemCode] [varchar](10) NOT NULL,
	[Date] [datetime] NULL,
	[BranchId] [int] NULL,
	[VendorName] [varchar](100) NULL,
	[ConditionCode] [int] NOT NULL,
	[StatusOut] [int] NOT NULL,
	[PIC] [varchar](50) NOT NULL,
	[Description] [varchar](255) NULL,
	[Status] [varchar](1) NOT NULL,
	[RepairStatus] [varchar](1) NULL,
	[RepairState] [int] NULL,
	[RepairCondition] [int] NULL,
	[RepairDescription] [varchar](255) NULL,
	[ApprovalState] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ItemOut] PRIMARY KEY CLUSTERED 
(
	[ITItemOutCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_ItemTrans
PRINT 'CREATE TABLE IT_ItemTrans'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans] DROP CONSTRAINT [FK_IT_ItemTrans_MsBranch1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans] DROP CONSTRAINT [FK_IT_ItemTrans_MsBranch]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ItemTrans]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ItemTrans](
	[ITItemTransCode] [varchar](8) NOT NULL,
	[BranchId_From] [int] NULL,
	[BranchId_To] [int] NULL,
	[DateTrans] [datetime] NOT NULL,
	[Status] [varchar](1) NOT NULL,
	[ApprovalState] [int] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ItemTrans] PRIMARY KEY CLUSTERED 
(
	[ITItemTransCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO




--** IT_ItemTransDtl
PRINT 'CREATE TABLE IT_ItemTransDtl'
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] DROP CONSTRAINT [FK_IT_ItemTransDtl_MsPrivilege]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_ItemTrans]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] DROP CONSTRAINT [FK_IT_ItemTransDtl_IT_ItemTrans]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] DROP CONSTRAINT [FK_IT_ItemTransDtl_IT_Item]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ItemTransDtl]
GO



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ItemTransDtl](
	[ITItemTransDtlCode] [varchar](10) NOT NULL,
	[ITItemTransCode] [varchar](8) NOT NULL,
	[ITItemCode] [varchar](10) NOT NULL,
	[ConditionCode] [int] NOT NULL,
	[UsedBy] [varchar](50) NULL,
	[PrivilegeCode] [varchar](4) NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ItemTransDtl] PRIMARY KEY CLUSTERED 
(
	[ITItemTransDtlCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** IT_ScheduleTask
PRINT 'CREATE TABLE IT_ScheduleTask'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ScheduleTask]') AND type in (N'U'))
DROP TABLE [dbo].[IT_ScheduleTask]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IT_ScheduleTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IT_ScheduleTask](
	[ScheduleNo] [varchar](8) NOT NULL,
	[ScheduleType] [varchar](1) NOT NULL,
	[ScheduleTitle] [varchar](255) NOT NULL,
	[Description] [varchar](255) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[IntervalBy] [varchar](1) NULL,
	[IntervalRange] [int] NULL,
	[IntervalHour] [varchar](2) NULL,
	[IntervalMinute] [varchar](2) NULL,
	[Status] [varchar](1) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](50) NULL,
 CONSTRAINT [PK_IT_ScheduleTask] PRIMARY KEY CLUSTERED 
(
	[ScheduleNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO


--** MsMeasurement
PRINT 'CREATE TABLE MsMeasurement'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMeasurement]') AND type in (N'U'))
DROP TABLE [dbo].[MsMeasurement]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMeasurement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsMeasurement](
	[measurement_code] [varchar](10) NOT NULL,
	[description] [varchar](30) NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](10) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](10) NULL,
 CONSTRAINT [pk_measurement] PRIMARY KEY CLUSTERED 
(
	[measurement_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO




--** MsCurrency
PRINT 'CREATE TABLE MsCurrency'
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_MsCurrency_update_date]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MsCurrency] DROP CONSTRAINT [DF_MsCurrency_update_date]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsCurrency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MsCurrency](
	[currency_code] [varchar](3) NOT NULL,
	[description] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [varchar](10) NOT NULL,
	[update_date] [datetime] NULL,
	[update_by] [varchar](10) NULL,
 CONSTRAINT [pk_mscurrency] PRIMARY KEY CLUSTERED 
(
	[currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--** Create Constraint

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilege_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilege]'))
ALTER TABLE [dbo].[MsPrivilege]  WITH CHECK ADD  CONSTRAINT [FK_MsPrivilege_MsDepartement] FOREIGN KEY([DepartementCode])
REFERENCES [dbo].[MsDepartement] ([DepartementCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilege_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilege]'))
ALTER TABLE [dbo].[MsPrivilege] CHECK CONSTRAINT [FK_MsPrivilege_MsDepartement]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt]  WITH CHECK ADD  CONSTRAINT [FK_MsPrivilegeDt_MsMenu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MsMenu] ([MenuId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt] CHECK CONSTRAINT [FK_MsPrivilegeDt_MsMenu]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt]  WITH CHECK ADD  CONSTRAINT [FK_MsPrivilegeDt_MsPrivilege] FOREIGN KEY([PrivilegeCode])
REFERENCES [dbo].[MsPrivilege] ([PrivilegeCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsPrivilegeDt_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsPrivilegeDt]'))
ALTER TABLE [dbo].[MsPrivilegeDt] CHECK CONSTRAINT [FK_MsPrivilegeDt_MsPrivilege]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsItem_MsItemGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsItemType]'))
ALTER TABLE [dbo].[MsItemType]  WITH CHECK ADD  CONSTRAINT [FK_MsItem_MsItemGroup] FOREIGN KEY([item_group_code])
REFERENCES [dbo].[MsItemGroup] ([item_group_code])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsItem_MsItemGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsItemType]'))
ALTER TABLE [dbo].[MsItemType] CHECK CONSTRAINT [FK_MsItem_MsItemGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApproval_MsBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] CHECK CONSTRAINT [FK_MsMappingApproval_MsBranch]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApproval_MsMenu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MsMenu] ([MenuId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] CHECK CONSTRAINT [FK_MsMappingApproval_MsMenu]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApproval_MsPrivilege] FOREIGN KEY([PrivilegeCode])
REFERENCES [dbo].[MsPrivilege] ([PrivilegeCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] CHECK CONSTRAINT [FK_MsMappingApproval_MsPrivilege]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege1]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApproval_MsPrivilege1] FOREIGN KEY([ParentCode])
REFERENCES [dbo].[MsPrivilege] ([PrivilegeCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsPrivilege1]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] CHECK CONSTRAINT [FK_MsMappingApproval_MsPrivilege1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApproval_MsUsers] FOREIGN KEY([UserIdApproval])
REFERENCES [dbo].[MsUsers] ([UserId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApproval_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApproval]'))
ALTER TABLE [dbo].[MsMappingApproval] CHECK CONSTRAINT [FK_MsMappingApproval_MsUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsMappingApproval]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApprovalMail_MsMappingApproval] FOREIGN KEY([ApprovalID])
REFERENCES [dbo].[MsMappingApproval] ([ApprovalID])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsMappingApproval]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail] CHECK CONSTRAINT [FK_MsMappingApprovalMail_MsMappingApproval]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail]  WITH CHECK ADD  CONSTRAINT [FK_MsMappingApprovalMail_MsUsers] FOREIGN KEY([UserEmail])
REFERENCES [dbo].[MsUsers] ([UserId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMappingApprovalMail_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMappingApprovalMail]'))
ALTER TABLE [dbo].[MsMappingApprovalMail] CHECK CONSTRAINT [FK_MsMappingApprovalMail_MsUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMenuSearch_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]'))
ALTER TABLE [dbo].[MsMenuSearch]  WITH CHECK ADD  CONSTRAINT [FK_MsMenuSearch_MsMenu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MsMenu] ([MenuId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMenuSearch_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]'))
ALTER TABLE [dbo].[MsMenuSearch] CHECK CONSTRAINT [FK_MsMenuSearch_MsMenu]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_IT_ActivityTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityAssign_IT_ActivityTask] FOREIGN KEY([ActivityNo])
REFERENCES [dbo].[IT_ActivityTask] ([ActivityNo])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_IT_ActivityTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] CHECK CONSTRAINT [FK_IT_ActivityAssign_IT_ActivityTask]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityAssign_MsUsers] FOREIGN KEY([AssignTo])
REFERENCES [dbo].[MsUsers] ([UserId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] CHECK CONSTRAINT [FK_IT_ActivityAssign_MsUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityAssign_MsUsers1] FOREIGN KEY([AssignFrom])
REFERENCES [dbo].[MsUsers] ([UserId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityAssign_MsUsers1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityAssign]'))
ALTER TABLE [dbo].[IT_ActivityAssign] CHECK CONSTRAINT [FK_IT_ActivityAssign_MsUsers1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityTask_MsBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] CHECK CONSTRAINT [FK_IT_ActivityTask_MsBranch]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityTask_MsDepartement] FOREIGN KEY([DepartementCode])
REFERENCES [dbo].[MsDepartement] ([DepartementCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsDepartement]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] CHECK CONSTRAINT [FK_IT_ActivityTask_MsDepartement]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask]  WITH CHECK ADD  CONSTRAINT [FK_IT_ActivityTask_MsItemType] FOREIGN KEY([item_type_code])
REFERENCES [dbo].[MsItemType] ([item_type_code])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ActivityTask_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ActivityTask]'))
ALTER TABLE [dbo].[IT_ActivityTask] CHECK CONSTRAINT [FK_IT_ActivityTask_MsItemType]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_Item_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_Item] ADD  CONSTRAINT [DF_IT_Item_IsActive]  DEFAULT ((1)) FOR [IsActive]
END

GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemInDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_IT_ItemInDtl] FOREIGN KEY([ITItemInDtlCode])
REFERENCES [dbo].[IT_ItemInDtl] ([ITItemInDtlCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemInDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_IT_ItemInDtl]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemTransDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_IT_ItemTransDtl] FOREIGN KEY([ITItemTransDtlCode])
REFERENCES [dbo].[IT_ItemTransDtl] ([ITItemTransDtlCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_IT_ItemTransDtl]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_IT_ItemTransDtl]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_MsBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_MsBranch]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_MsCondition] FOREIGN KEY([ConditionCode])
REFERENCES [dbo].[MsCondition] ([ConditionCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_MsCondition]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_MsItemType] FOREIGN KEY([item_type_code])
REFERENCES [dbo].[MsItemType] ([item_type_code])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_MsItemType]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item]  WITH CHECK ADD  CONSTRAINT [FK_IT_Item_MsPrivilege] FOREIGN KEY([PrivilegeCode])
REFERENCES [dbo].[MsPrivilege] ([PrivilegeCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_Item_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_Item]'))
ALTER TABLE [dbo].[IT_Item] CHECK CONSTRAINT [FK_IT_Item_MsPrivilege]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_Item_History_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_Item_History] ADD  CONSTRAINT [DF_IT_Item_History_IsActive]  DEFAULT ((1)) FOR [IsActive]
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_IT_ItemIn_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IT_ItemIn] ADD  CONSTRAINT [DF_IT_ItemIn_Status]  DEFAULT ('D') FOR [Status]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_IT_ItemIn]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemInDtl_IT_ItemIn] FOREIGN KEY([ITItemInCode])
REFERENCES [dbo].[IT_ItemIn] ([ITItemInCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_IT_ItemIn]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] CHECK CONSTRAINT [FK_IT_ItemInDtl_IT_ItemIn]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemInDtl_MsCondition] FOREIGN KEY([ConditionCode])
REFERENCES [dbo].[MsCondition] ([ConditionCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] CHECK CONSTRAINT [FK_IT_ItemInDtl_MsCondition]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemInDtl_MsItemType] FOREIGN KEY([item_type_code])
REFERENCES [dbo].[MsItemType] ([item_type_code])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemInDtl_MsItemType]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemInDtl]'))
ALTER TABLE [dbo].[IT_ItemInDtl] CHECK CONSTRAINT [FK_IT_ItemInDtl_MsItemType]
GO


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemOut_IT_Item] FOREIGN KEY([ITItemCode])
REFERENCES [dbo].[IT_Item] ([ITItemCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] CHECK CONSTRAINT [FK_IT_ItemOut_IT_Item]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemOut_MsBranch] FOREIGN KEY([BranchId])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] CHECK CONSTRAINT [FK_IT_ItemOut_MsBranch]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemOut_MsCondition] FOREIGN KEY([ConditionCode])
REFERENCES [dbo].[MsCondition] ([ConditionCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] CHECK CONSTRAINT [FK_IT_ItemOut_MsCondition]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemOut_MsCondition1] FOREIGN KEY([RepairCondition])
REFERENCES [dbo].[MsCondition] ([ConditionCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemOut_MsCondition1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemOut]'))
ALTER TABLE [dbo].[IT_ItemOut] CHECK CONSTRAINT [FK_IT_ItemOut_MsCondition1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemTrans_MsBranch] FOREIGN KEY([BranchId_From])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans] CHECK CONSTRAINT [FK_IT_ItemTrans_MsBranch]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemTrans_MsBranch1] FOREIGN KEY([BranchId_To])
REFERENCES [dbo].[MsBranch] ([BranchId])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTrans_MsBranch1]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTrans]'))
ALTER TABLE [dbo].[IT_ItemTrans] CHECK CONSTRAINT [FK_IT_ItemTrans_MsBranch1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemTransDtl_IT_Item] FOREIGN KEY([ITItemCode])
REFERENCES [dbo].[IT_Item] ([ITItemCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] CHECK CONSTRAINT [FK_IT_ItemTransDtl_IT_Item]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_ItemTrans]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemTransDtl_IT_ItemTrans] FOREIGN KEY([ITItemTransCode])
REFERENCES [dbo].[IT_ItemTrans] ([ITItemTransCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_IT_ItemTrans]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] CHECK CONSTRAINT [FK_IT_ItemTransDtl_IT_ItemTrans]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl]  WITH CHECK ADD  CONSTRAINT [FK_IT_ItemTransDtl_MsPrivilege] FOREIGN KEY([PrivilegeCode])
REFERENCES [dbo].[MsPrivilege] ([PrivilegeCode])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IT_ItemTransDtl_MsPrivilege]') AND parent_object_id = OBJECT_ID(N'[dbo].[IT_ItemTransDtl]'))
ALTER TABLE [dbo].[IT_ItemTransDtl] CHECK CONSTRAINT [FK_IT_ItemTransDtl_MsPrivilege]
GO

ROLLBACK TRAN ScriptTable123
GO