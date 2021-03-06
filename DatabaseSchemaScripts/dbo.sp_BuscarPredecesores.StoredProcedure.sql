USE [Predecesores]
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarPredecesores]    Script Date: 02/06/2022 03:53:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_BuscarPredecesores] @Malla VARCHAR(50)
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
    INTO #Job_Pred2
    FROM
    (
        SELECT
        SUBSTRING(Release,1, CHARINDEX('.', Release, 1)-1) Parent,
        SUBSTRING(Job, 1, CHARINDEX('.', Job, 1)-1) Child --SELECT *
        FROM Pred
        WHERE JOB LIKE '%'+@Malla AND Release LIKE '%'+@Malla AND Release IS NOT NULL
    ) A;

    SELECT @Total=count(*) from #Job_Pred2;

    Create table #TemporalMalla3(
    Id int primary key not null identity(1,1),
    JOB varchar(max),
    Release varchar(max)
    )

    CREATE TABLE #RelacionMallas2(
        Id int primary key not null identity(1,1),
        Parent VARCHAR(MAX),
        Child VARCHAR(MAX)
    )

    INSERT INTO #TemporalMalla3(JOB,release)
    SELECT Child, Parent 
    FROM #Job_Pred2;

    WHILE(@Conteo<=@Total)
        BEGIN
            SELECT @Parent=SUBSTRING(JOB,0,9),@Childs=SUBSTRING(release,0,9) 
            FROM #TemporalMalla3 
            WHERE Id=@Conteo
    
    
            IF NOT EXISTS(SELECT * FROM #RelacionMallas2 WHERE Parent=@Parent AND Child=@Childs)
                BEGIN
        --PRINT(@cursor)
                    INSERT INTO #RelacionMallas2(Parent,Child) 
                    VALUES(@Parent, @Childs)
                END
    
            SET @Conteo=@Conteo+1
        --PRINT(@Parent + ' ' +@Childs)
        END
DROP TABLE #TemporalMalla3;
DROP TABLE #Job_Pred2;
SELECT ID, Child Parent, Parent Child FROM #RelacionMallas2;
END;
GO
