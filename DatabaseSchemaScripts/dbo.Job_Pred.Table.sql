USE [Predecesores]
GO
/****** Object:  Table [dbo].[Job_Pred]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_Pred](
	[Parent] [varchar](max) NULL,
	[Child] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
