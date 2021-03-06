USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_Test]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [dbo].[sp_Test] @forjob VARCHAR(50)
AS
BEGIN
TRUNCATE TABLE Temp;

INSERT INTO Temp
SELECT Parent, Child FROM(
SELECT 
    JOB Parent, 
    Release Child
FROM Pred P---- where Release IS NOT NULL
WHERE P.JOB LIKE @forjob+'%' OR P.Release LIKE @forjob+'%'
UNION
SELECT 
    JOB Parent, 
    Release Child
FROM Pred P---- where Release IS NOT NULL
WHERE P.JOB NOT LIKE @forjob+'%' OR P.Release NOT LIKE @forjob+'%'
) A 
WHERE A.Child IS NOT NULL;

END;
GO
