USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_LimpiezaP]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_LimpiezaP]
AS 
BEGIN
    TRUNCATE TABLE Pred;
    INSERT INTO Pred
        SELECT
            CASE
                WHEN JOB LIKE '---%' THEN 'JOB'
                WHEN Tipo LIKE 'UNIX%' THEN 'UNIX_JOB'
                WHEN Tipo LIKE 'NT%' THEN 'NT_JOB'
            END [Tipo Job],
            CASE
                WHEN JOB LIKE '--%' THEN REPLACE(JOB, '-', '')
                ELSE JOB
            END [JOB],
            CASE
                WHEN RELEASE LIKE '%*%' THEN SUBSTRING(Release,1,CHARINDEX('/', Release)-1)
                ELSE Release
            END [Release]
        FROM Predecesores;
        --ORDER BY 3 DESC;
END;
GO
