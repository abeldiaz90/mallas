USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaJobs]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_ListaJobs] @Malla VARCHAR(50)
AS
DECLARE @Parent varchar(max)
DECLARE @Childs varchar(max)
DECLARE @Total INT
DECLARE @Conteo INT
DECLARE @cursor int
SET @Total=0
SET @Conteo=1
BEGIN
    SELECT 
    A.*
    INTO #Job_Pred
    FROM
    (
        SELECT
        SUBSTRING(Release,1, CHARINDEX('.', Release, 1)-1) Parent,
        SUBSTRING(Job, 1, CHARINDEX('.', Job, 1)-1) Child --SELECT *
        FROM Pred
        WHERE JOB LIKE '%'+@Malla AND Release LIKE '%'+@Malla AND Release IS NOT NULL
    ) A;

    SELECT @Total=count(*) from #Job_Pred;

    Create table #TemporalMalla2(
    Id int primary key not null identity(1,1),
    JOB varchar(max),
    Release varchar(max)
    )

    INSERT INTO #TemporalMalla2(JOB,release)
    SELECT Child, Parent 
    FROM #Job_Pred;

    CREATE TABLE #RelacionMallas(
        Id int primary key not null identity(1,1),
        Parent VARCHAR(MAX),
        Child VARCHAR(MAX)
    )

    WHILE(@Conteo<=@Total)
        BEGIN
            SELECT @Parent=SUBSTRING(JOB,0,9),@Childs=SUBSTRING(release,0,9) 
            FROM #TemporalMalla2
            WHERE Id=@Conteo
    
    
            IF NOT EXISTS(SELECT * FROM #RelacionMallas WHERE Parent=@Parent AND Child=@Childs)
                BEGIN
                    INSERT INTO #RelacionMallas(Parent,Child) 
                    VALUES(@Parent, @Childs)
                END
    
            SET @Conteo=@Conteo+1
        END
DROP TABLE #TemporalMalla2;
DROP TABLE #Job_Pred;
SELECT 
    DISTINCT A.* 
    FROM (
        SELECT 
            Parent Jobs
        FROM #RelacionMallas
        UNION
        SELECT 
            Child Jobs
        FROM #RelacionMallas
    ) A 
ORDER BY Jobs;
END;
GO
