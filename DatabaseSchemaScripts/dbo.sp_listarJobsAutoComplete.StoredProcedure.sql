USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_listarJobsAutoComplete]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_listarJobsAutoComplete] @job VARCHAR(100)
AS
SELECT DISTINCT A.Jobs 
FROM (
SELECT 
JOB Jobs
FROM Pred P WHERE P.JOB LIKE '%.%'
UNION
SELECT 
Release Jobs
FROM Pred P WHERE P.Release LIKE '%.%'
) A
WHERE A.Jobs LIKE '%'+@job+'%';
GO
