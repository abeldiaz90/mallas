USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscaForJobSucesor]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_BuscaForJobSucesor] @forjob VARCHAR(50)
AS
BEGIN
DROP TABLE IF EXISTS #Temp;
CREATE TABLE #Temp(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Parent VARCHAR(MAX),
    Child VARCHAR(MAX)
)

INSERT INTO #Temp
/*
SELECT 
    SUBSTRING(Job,1,CHARINDEX('.',P.JOB,1)-1) Parent, 
    Release Child
FROM Pred P---- where Release IS NOT NULL
WHERE P.JOB LIKE @forjob + '%' OR P.Release LIKE @forjob+'%'
AND Release IS NOT NULL
AND P.JOB LIKE '%.%'
*/
SELECT Parent, Child FROM(
SELECT 
    JOB Parent, 
    Release Child
FROM Pred P---- where Release IS NOT NULL
WHERE P.JOB LIKE '@P1LK000%' OR P.Release LIKE '@P1LK000%'
UNION
SELECT 
    JOB Parent, 
    Release Child
FROM Pred P---- where Release IS NOT NULL
WHERE P.JOB NOT LIKE '@P1LK000%' OR P.Release NOT LIKE '@P1LK000%'
) A 
WHERE A.Child IS NOT NULL;

SELECT Id, Child Parent, Parent Child FROM #Temp;
DROP TABLE #Temp;
END;
GO
