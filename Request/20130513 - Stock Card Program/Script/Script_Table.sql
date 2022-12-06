--* Menu Search
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsMenuSearch_MsMenu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]'))
BEGIN
	PRINT 'DROP CONSTRAINT TABLE MsMenuSearch'
	ALTER TABLE [dbo].[MsMenuSearch] DROP CONSTRAINT [FK_MsMenuSearch_MsMenu]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsMenuSearch]') AND type in (N'U'))
BEGIN
	PRINT 'DROP TABLE MsMenuSearch'
	DROP TABLE [dbo].[MsMenuSearch]
END
GO

PRINT 'CREATE TABLE MsMenuSearch'
GO

CREATE TABLE [dbo].[MsMenuSearch](
	[MenuId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[ParamName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParamField] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MsMenuSearch] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC,
	[SequenceNo] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

PRINT 'CREATE CONSTRAINT TABLE MsMenuSearch'
GO

ALTER TABLE [dbo].[MsMenuSearch]  WITH CHECK ADD  CONSTRAINT [FK_MsMenuSearch_MsMenu] FOREIGN KEY([MenuId])
	REFERENCES [dbo].[MsMenu] ([MenuId])
GO