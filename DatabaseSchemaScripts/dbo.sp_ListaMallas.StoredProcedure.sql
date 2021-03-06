USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaMallas]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_ListaMallas]
AS
BEGIN
    SELECT 
        DISTINCT RIGHT(JOB, CHARINDEX('.',JOB, 1 ) - 1) Malla --SELECT *
    FROM Pred
    WHERE JOB LIKE '%.%'
    AND LEN(RIGHT(JOB, CHARINDEX('.',JOB, 1 ) - 1))>5
    ORDER BY 1
END;
GO
