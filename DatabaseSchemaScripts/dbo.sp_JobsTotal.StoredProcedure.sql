USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_JobsTotal]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_JobsTotal]
AS
SELECT DISTINCT A.Jobs 
FROM (
SELECT 
JOB Jobs
--SUBSTRING(P.JOB, 1, CHARINDEX('.', P.JOB, 1)-1) Jobs
FROM Pred P
WHERE P.JOB LIKE '%.%'
UNION
SELECT 
Release Jobs
--SUBSTRING(P.Release, 1, CHARINDEX('.', P.Release, 1)-1) Jobs
FROM Pred P
WHERE P.Release LIKE '%.%'
) A
ORDER BY 1
GO
