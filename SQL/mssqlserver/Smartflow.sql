USE [Smartflow]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAssistant]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GetAssistant]
(	
	-- Add the parameters for the function here
	 @InstanceID varchar(50),
	 @NodeID varchar(50)
)
RETURNS varchar(50)  
AS
BEGIN


    DECLARE @result int
	SELECT @result=COUNT(1) FROM [dbo].[t_pending] WHERE InstanceID=@InstanceID AND NodeID=@NodeID AND  NodeID NOT IN (SELECT NodeID  FROM [dbo].[t_assistant] WHERE [InstanceID]=@InstanceID)
   
    RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNodeNames]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[GetNodeNames](@InstanceID varchar(50)) 
returns varchar(1024)
as
begin
declare @Names varchar(1024)
set @Names=''
select @Names=@Names+(select name from t_node n where InstanceID=@InstanceID AND [RelationshipID]=n.ID)+','  from t_link where InstanceID=@InstanceID

if(len(@Names)>0)
begin
set @Names=left(@Names,len(@Names)-1)

end
return @Names
end
GO
/****** Object:  Table [dbo].[t_action]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_action](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[ID] [varchar](512) NULL,
	[Name] [varchar](512) NULL,
	[InstanceID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_t_action] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_actor]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_actor](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_t_actor] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_assistant]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_assistant](
	[NID] [varchar](50) NOT NULL,
	[InstanceID] [varchar](50) NULL,
	[NodeID] [varchar](50) NULL,
	[Total] [int] NULL,
 CONSTRAINT [PK_t_assistant] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_bridge]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_bridge](
	[InstanceID] [varchar](50) NOT NULL,
	[CategoryCode] [varchar](50) NULL,
	[Comment] [varchar](512) NULL,
	[Key] [varchar](50) NULL,
	[Creator] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_t_bridge] PRIMARY KEY CLUSTERED 
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_carbon]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_carbon](
	[NID] [varchar](50) NOT NULL,
	[InstanceID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[ID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[RelationshipID] [varchar](50) NULL,
 CONSTRAINT [PK_t_carbon] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_carbonCopy]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_carbonCopy](
	[NID] [varchar](50) NOT NULL,
	[ActorID] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[NodeID] [varchar](50) NULL,
 CONSTRAINT [PK_t_carbonCopy] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_category]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_category](
	[NID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
	[Url] [varchar](512) NULL,
	[ParentID] [varchar](50) NULL,
 CONSTRAINT [PK_t_category] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_command]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_command](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[Text] [varchar](4000) NULL,
	[InstanceID] [varchar](50) NULL,
 CONSTRAINT [PK_t_command] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_config]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_config](
	[ID] [bigint] NOT NULL,
	[Name] [varchar](50) NULL,
	[ConnectionString] [varchar](512) NULL,
	[ProviderName] [varchar](50) NULL,
 CONSTRAINT [PK_t_config] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_constraint]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_constraint](
	[NID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_t_stragery] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_cooperation]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_cooperation](
	[NID] [varchar](50) NOT NULL,
	[InstanceID] [varchar](50) NULL,
	[TransitionID] [varchar](50) NULL,
	[NodeID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_t_cooperation] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_group]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_group](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
 CONSTRAINT [PK_t_role] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_instance]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_instance](
	[InstanceID] [varchar](50) NOT NULL,
	[CreateTime] [datetime] NULL,
	[State] [varchar](50) NULL,
	[Resource] [text] NULL,
 CONSTRAINT [PK_t_instance] PRIMARY KEY CLUSTERED 
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_link]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_link](
	[NID] [varchar](50) NOT NULL,
	[InstanceID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_t_sub] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_mail]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_mail](
	[ID] [int] NOT NULL,
	[Account] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Host] [varchar](50) NULL,
	[Port] [int] NULL,
	[EnableSsl] [int] NULL,
 CONSTRAINT [PK_t_mail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_node]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_node](
	[NID] [varchar](50) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
	[NodeType] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[Cooperation] [varchar](256) NULL,
	[Assistant] [varchar](512) NULL,
	[Veto] [varchar](256) NULL,
	[Back] [varchar](256) NULL,
	[Url] [varchar](512) NULL,
 CONSTRAINT [PK_t_node] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_organization]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_organization](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
 CONSTRAINT [PK_t_organization] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_pending]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_pending](
	[NID] [varchar](50) NOT NULL,
	[ActorID] [varchar](50) NULL,
	[NodeID] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[NodeName] [varchar](50) NULL,
	[CategoryCode] [varchar](50) NULL,
	[CategoryName] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[Url] [varchar](512) NULL,
 CONSTRAINT [PK_t_pending] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_process]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_process](
	[NID] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NULL,
	[Destination] [varchar](50) NULL,
	[TransitionID] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[NodeType] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[RelationshipID] [varchar](50) NULL,
	[Direction] [varchar](50) NULL,
	[ActorID] [varchar](50) NULL,
 CONSTRAINT [PK_t_process] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_record]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_record](
	[NID] [varchar](50) NOT NULL,
	[NodeID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Comment] [text] NULL,
	[InstanceID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[Url] [varchar](2048) NULL,
	[AuditUserID] [varchar](50) NULL,
	[AuditUserName] [varchar](50) NULL,
 CONSTRAINT [PK_t_record] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_rule]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_rule](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
 CONSTRAINT [PK_t_rule] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_script]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_script](
	[ID] [varchar](50) NOT NULL,
	[CategoryCode] [varchar](50) NULL,
	[Text] [text] NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_t_script] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_structure]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_structure](
	[NID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
	[Resource] [text] NULL,
	[CategoryCode] [varchar](50) NULL,
	[CategoryName] [varchar](50) NULL,
	[Status] [int] NULL,
	[CreateTime] [datetime] NULL,
	[Memo] [text] NULL,
 CONSTRAINT [PK_T_STRUCTURE] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_transition]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_transition](
	[NID] [varchar](50) NOT NULL,
	[RelationshipID] [varchar](50) NULL,
	[Name] [varchar](128) NULL,
	[Destination] [varchar](50) NULL,
	[Origin] [varchar](50) NULL,
	[InstanceID] [varchar](50) NULL,
	[Expression] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
 CONSTRAINT [PK_t_transition_1] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_summary]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE view [dbo].[v_summary]
as

   select (select Name from [dbo].[t_category]  t where t.NID=b.CategoryCode) CategoryName,InstanceID,CategoryCode,Comment,[Key],

 [dbo].[GetNodeNames](b.InstanceID) NodeName, 
	(SELECT i.State  FROM t_instance i WHERE i.InstanceID=b.InstanceID) [State],
    (SELECT Name FROM [Demo].dbo.t_sys_user where ID=Creator) Name,
	(SELECT (select  Name FROM  [Demo].[dbo].[t_sys_organization] WHERE ID=[OrganizationCode])  FROM [Demo].dbo.t_sys_user where ID=Creator) OrganizationName,
   Creator,CreateTime from t_bridge b
GO
/****** Object:  View [dbo].[v_supervise]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO















CREATE view [dbo].[v_supervise]
as



   select (select Name from [dbo].[t_category]  t where t.NID=b.CategoryCode) CategoryName,b.InstanceID,CategoryCode,Comment,[Key],

    (SELECT (SELECT NAME FROM t_node n WHERE n.ID=l.RelationshipID and n.InstanceID=b.InstanceID) ) NodeName,
	l.RelationshipID AS NodeID,
 	(SELECT i.State  FROM t_instance i WHERE i.InstanceID=b.InstanceID) [State],
    (SELECT Name FROM  [Demo].dbo.t_sys_user where ID=Creator) Name,
	(SELECT (select  Name FROM  [Demo].[dbo].[t_sys_organization] WHERE ID=[OrganizationCode])  FROM  [Demo].dbo.t_sys_user where ID=Creator) OrganizationName,
   Creator,CreateTime from t_bridge b left join t_link l on (b.InstanceID=l.InstanceID ) 



GO
ALTER TABLE [dbo].[t_action] ADD  CONSTRAINT [DF_t_action_CreateDateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[t_actor] ADD  CONSTRAINT [DF_t_actor_INSERTDATE]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[t_carbon] ADD  CONSTRAINT [DF_t_carbon_NID]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_category] ADD  CONSTRAINT [DF_t_category_NID]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_constraint] ADD  CONSTRAINT [DF_t_stragery_NID]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_instance] ADD  CONSTRAINT [DF_t_instance_CreateDateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[t_instance] ADD  CONSTRAINT [DF_t_instance_STATUS]  DEFAULT ('running') FOR [State]
GO
ALTER TABLE [dbo].[t_link] ADD  CONSTRAINT [DF_t_sub_NID_1]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_link] ADD  CONSTRAINT [DF_t_sub_NID]  DEFAULT (newid()) FOR [InstanceID]
GO
ALTER TABLE [dbo].[t_mail] ADD  CONSTRAINT [DF_t_mail_EnableSsl]  DEFAULT ((0)) FOR [EnableSsl]
GO
ALTER TABLE [dbo].[t_node] ADD  CONSTRAINT [DF_t_node_NID]  DEFAULT ((0)) FOR [NID]
GO
ALTER TABLE [dbo].[t_node] ADD  CONSTRAINT [DF_t_node_Cooperation]  DEFAULT ((0)) FOR [Cooperation]
GO
ALTER TABLE [dbo].[t_pending] ADD  CONSTRAINT [DF_t_pending_NID]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_process] ADD  CONSTRAINT [DF_t_process_INSERTDATE]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[t_record] ADD  CONSTRAINT [DF_t_record_InsertDate]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[t_script] ADD  CONSTRAINT [DF_t_sys_command_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_NID]  DEFAULT (newid()) FOR [NID]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_StructName]  DEFAULT ('类型名称') FOR [Name]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_StructXml]  DEFAULT ('资源Xml') FOR [Resource]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_CateCode]  DEFAULT ('类型编号') FOR [CategoryCode]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_CateName]  DEFAULT ('类型名称') FOR [CategoryName]
GO
ALTER TABLE [dbo].[t_structure] ADD  CONSTRAINT [DF_t_structure_CreateDateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  StoredProcedure [dbo].[SMF_DELETE_RECORD]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SMF_DELETE_RECORD](@InstanceID VARCHAR(50),@Key VARCHAR(50),@CategoryCode VARCHAR(50))
 
AS

BEGIN

DECLARE @commandText nvarchar(2048)
DECLARE @ID varchar(50)

DELETE FROM [dbo].t_command WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_action  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_actor  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_group  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].[t_carbon]  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].[t_organization]  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_instance      WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_node          WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_process       WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_transition    WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_pending       WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_record        WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_bridge        WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_cooperation   WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_assistant     WHERE InstanceID=@InstanceID;
BEGIN
    SET @ID=@Key
	DECLARE command_cursor cursor
	FOR SELECT [Text] FROM t_script WHERE  CategoryCode=@CategoryCode Order by Sort 
	--打开游标--
	OPEN command_cursor
	--开始循环游标变量--
	FETCH NEXT FROM command_cursor INTO @commandText
	WHILE @@FETCH_STATUS = 0    --返回被 FETCH语句执行的最后游标的状态--
		BEGIN            
			EXEC sp_executesql @commandText,N'@ID varchar(50)',@ID
			FETCH NEXT FROM command_cursor INTO @commandText   --转到下一个游标，没有会死循环
		END   
	CLOSE command_cursor        --关闭游标
	DEALLOCATE command_cursor   --释放游标

	END
END
GO
/****** Object:  StoredProcedure [dbo].[SMF_DELETE_WF_RECORD]    Script Date: 2020-11-18 21:32:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SMF_DELETE_WF_RECORD](@InstanceID VARCHAR(50))
 
AS

BEGIN


DELETE FROM [dbo].t_command WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_action  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_actor  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_group  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].[t_carbon]  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].[t_organization]  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_instance  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_node  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_process  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_transition  WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_pending       WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_record        WHERE InstanceID=@InstanceID;
--DELETE FROM [dbo].t_bridge        WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_cooperation   WHERE InstanceID=@InstanceID;
DELETE FROM [dbo].t_assistant     WHERE InstanceID=@InstanceID;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'RelationshipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参与者标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参与者的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参与者审批时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审批参与者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_actor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_category', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_command', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键，与t_node 表进行关键，即决策节点，对应的命令集合' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_command', @level2type=N'COLUMN',@level2name=N'RelationshipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL文本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_command', @level2type=N'COLUMN',@level2name=N'Text'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_command', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分支多条件命令' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_command'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据源名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_config', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_config', @level2type=N'COLUMN',@level2name=N'ConnectionString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问客户端如(System.Data.SqlClient)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_config', @level2type=N'COLUMN',@level2name=N'ProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流数据库配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键，与t_node 表进行关键，即一个节点多个参与组' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group', @level2type=N'COLUMN',@level2name=N'RelationshipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组的标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参与组' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键，实例ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_instance', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_instance', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程状态（运行中：running、结束：end、终止：termination,kill:杀死流程）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_instance', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储描述流程数据结构' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_instance', @level2type=N'COLUMN',@level2name=N'Resource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_instance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'子实例ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_link', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_link', @level2type=N'COLUMN',@level2name=N'RelationshipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码（授权码）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送邮件显示的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务器smtp.163.com' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'Host'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'端口(25)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'Port'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 启用HTTPS 0：http 1:https' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_mail', @level2type=N'COLUMN',@level2name=N'EnableSsl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点的标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点类型（Start\End\Normal\Decision）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node', @level2type=N'COLUMN',@level2name=N'NodeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 其他 1会签 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node', @level2type=N'COLUMN',@level2name=N'Cooperation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程节点表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_node'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前节点ID ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转节点的ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转路线的ID t_transition.NID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'TransitionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'NodeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转到的节点NID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process', @level2type=N'COLUMN',@level2name=N'RelationshipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录所有审批操作' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_process'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键标识 GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_structure', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程图模板名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_structure', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储描述流程数据结构' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_structure', @level2type=N'COLUMN',@level2name=N'Resource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程模板' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_structure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'NID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转到节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流实例ID 与 T_INSTANCE表关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'InstanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表达式（只有分支才用）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'Expression'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线的标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程跳转路线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N't_transition'
GO
