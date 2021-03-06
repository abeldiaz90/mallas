USE [Predecesores]
GO
/****** Object:  View [dbo].[V_PredecesorSucesor]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[V_PredecesorSucesor]
AS
SELECT 
A.[Tipo Job],
A.JOB Predecesores,
A.Release Sucesores,
A.Predecesor,
A.Sucesor,
'Datawarehouse' Tipo_Sucesor,
CASE 
    WHEN A.JOB LIKE 'JP%' THEN SUBSTRING(A.Predecesor, PATINDEX('%[0-9]%', A.Predecesor) +1 , 2)
    WHEN A.JOB LIKE '@P%' THEN SUBSTRING(a.Predecesor, PATINDEX('%[0-9]%', A.Predecesor) +1 , 2)
    ELSE SUBSTRING(A.Predecesor, 5, 2)
END Tipo_Predecesor
FROM (
SELECT A.*,
SUBSTRING(A.JOB, 1, CHARINDEX('.', A.JOB)-1) Predecesor,
SUBSTRING(A.Release, 1, CHARINDEX('.', A.Release)-1) Sucesor, 
CASE 
    WHEN JOB LIKE '___DW%' THEN 1
    WHEN JOB LIKE '___LK%' THEN 1
    WHEN JOB LIKE '_WC%' THEN 1
    WHEN JOB LIKE 'JDW%' THEN 1
    ELSE 0
END Filtro
FROM Pred A
WHERE Release LIKE '___DW%' OR Release LIKE '_WC%' OR Release LIKE 'JDW%'
) A
WHERE A.Filtro = 0
--------
UNION
--------
SELECT 
A.[Tipo Job],
A.JOB Predecesores,
A.Release Sucesores,
A.Predecesor,
A.Sucesor,
'DataLake' Tipo_Sucesor,
CASE 
    WHEN A.JOB LIKE 'JP%' THEN SUBSTRING(A.Predecesor, PATINDEX('%[0-9]%', A.Predecesor) +1 , 2)
    WHEN A.JOB LIKE '@P%' THEN SUBSTRING(a.Predecesor, PATINDEX('%[0-9]%', A.Predecesor) +1 , 2)
    ELSE SUBSTRING(A.Predecesor, 5, 2)
END Tipo_Predecesor
FROM (
SELECT A.*,
SUBSTRING(A.JOB, 1, CHARINDEX('.', A.JOB)-1) Predecesor,
SUBSTRING(A.Release, 1, CHARINDEX('.', A.Release)-1) Sucesor, 
CASE 
    WHEN JOB LIKE '___DW%' THEN 1
    WHEN JOB LIKE '___LK%' THEN 1
    WHEN JOB LIKE '_WC%' THEN 1
    WHEN JOB LIKE 'JDW%' THEN 1
    ELSE 0
END Filtro
FROM Pred A
WHERE Release LIKE '___LK%'
) A
WHERE A.Filtro = 0
GO
