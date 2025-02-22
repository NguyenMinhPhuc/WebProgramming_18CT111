Create database WebShopHocTapgo

USE [WebShopHocTap]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Alias] [nvarchar](50) NULL,
	[ParentID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Order] [int] NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Alias] [varchar](50) NULL,
	[CategoryID] [int] NULL,
	[Images] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Price] [decimal](18, 0) NULL,
	[Detail] [ntext] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [Alias], [ParentID], [CreateDate], [Order], [Status]) VALUES (1, N'Máy Laptop', N'May LapTop', 0, CAST(N'2021-03-22 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [Alias], [ParentID], [CreateDate], [Order], [Status]) VALUES (2, N'Điện thoại', N'Dien thoai', 0, CAST(N'2021-03-22 00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[Category] ([ID], [Name], [Alias], [ParentID], [CreateDate], [Order], [Status]) VALUES (3, N'Hàng mỹ phẩm', N'hang my pham', 0, CAST(N'2020-03-03 00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[Category] ([ID], [Name], [Alias], [ParentID], [CreateDate], [Order], [Status]) VALUES (4, N'Hàng thực phẩm', N'hang thuc pham', 0, CAST(N'2020-03-03 00:00:00.000' AS DateTime), 4, 0)
INSERT [dbo].[Category] ([ID], [Name], [Alias], [ParentID], [CreateDate], [Order], [Status]) VALUES (5, N'Hàng Công nghệ', N'hang cong nghe fhalsdfhk', 0, CAST(N'2021-03-23 00:00:00.000' AS DateTime), 5, 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_Status]  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  StoredProcedure [dbo].[PSP_Category_DeleteByID]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PSP_Category_DeleteByID]
@ID int
AS
IF EXISTS (SELECT 1 FROM dbo.Category where id=@ID)
BEGIN
    UPDATE dbo.Category
	SET [status]=0
	where id=@ID
END 
GO
/****** Object:  StoredProcedure [dbo].[PSP_Category_GetCategories]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	 PROC [dbo].[PSP_Category_GetCategories]
AS
SELECT ID, Name, Alias, ParentID, CreateDate, [Order], [STATUS]
FROM [dbo].[Category]
ORDER BY [Order] DESC
GO
/****** Object:  StoredProcedure [dbo].[PSP_Category_GetCategoryByID]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create	 PROC [dbo].[PSP_Category_GetCategoryByID]
@ID int
AS
SELECT ID, Name, Alias, ParentID, CreateDate, [Order], [STATUS]
FROM [dbo].[Category]
WHERE ID=@ID
ORDER BY [Order] DESC
GO
/****** Object:  StoredProcedure [dbo].[PSP_Category_InsertCategory]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PSP_Category_InsertCategory]
    @Name NVARCHAR(50) ,
    @Alias NVARCHAR(50) ,
    @ParentID INT ,
    @CreateDate DATE ,
    @Order INT ,
    @Status BIT
AS
    INSERT  INTO Category( Name, Alias, ParentID, CreateDate, [Order], [Status])
	VALUES( @Name, @Alias, @ParentID, @CreateDate, @Order, @Status)
            
GO
/****** Object:  StoredProcedure [dbo].[PSP_Category_InsertUpdateCategory]    Script Date: 27/03/2021 08:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[PSP_Category_InsertUpdateCategory]
	@ID INT,
    @Name NVARCHAR(50) ,
    @Alias NVARCHAR(50) ,
    @ParentID INT ,
    @CreateDate DATE ,
    @Order INT ,
    @Status BIT
AS
IF EXISTS (SELECT 1 FROM dbo.Category where ID=@ID)
BEGIN
    UPDATE dbo.Category
	SET  Name=@Name, Alias=@Alias, ParentID=@ParentID, CreateDate=@CreateDate, [ORDER]=@Order, [Status]=@Status
	WHERE ID=@ID
END
ELSE	
BEGIN
     INSERT  INTO Category( Name, Alias, ParentID, CreateDate, [Order], [Status])
	VALUES( @Name, @Alias, @ParentID, @CreateDate, @Order, @Status)
END
   
            
GO
