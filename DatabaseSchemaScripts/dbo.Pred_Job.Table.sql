USE [Predecesores]
GO
/****** Object:  Table [dbo].[Pred_Job]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pred_Job](
	[Tipo Job] [varchar](8) NULL,
	[JOB] [varchar](max) NULL,
	[Release] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
