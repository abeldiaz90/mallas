USE [Predecesores]
GO
/****** Object:  Table [dbo].[Predecesores]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Predecesores](
	[Tipo] [varchar](50) NULL,
	[Job] [varchar](max) NULL,
	[Release] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
