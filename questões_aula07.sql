-- Questão 01. Crie um procedimento chamado student_grade_points
-- a. Parâmetro de entrada: conceito (Ex: A+, A-)
-- b. Retorno: Nome, Depto Estudante, Título Curso, Depto Curso, Semestre, Ano, 
--             Pontuação alfanumérica, Pontuação numérica.
-- c. Filtro: parâmetro de entrada.
CREATE OR ALTER PROCEDURE dbo.student_grade_points
    @conceito VARCHAR(5)
AS
BEGIN
    SELECT 
        s.name AS Nome_Estudante,
        s.dept_name AS Departamento_Estudante,
        c.title AS Titulo_Curso,
        c.dept_name AS Departamento_Curso,
        t.semester AS Semestre_Curso,
        t.year AS Ano_Curso,
        t.grade AS Pontuacao_Alfanumerica,
        gp.points AS Pontuacao_Numerica
    FROM dbo.student s
    JOIN dbo.takes t 
        ON s.ID = t.ID
    JOIN dbo.course c 
        ON t.course_id = c.course_id
    LEFT JOIN dbo.grade_points gp 
        ON t.grade = gp.grade
    WHERE t.grade = @conceito;
END;




-- Questão 02. Crie uma função chamada return_instructor_location
-- a. Parâmetro de entrada: nome do instrutor.
-- b. Retorno: Nome instrutor, Curso ministrado, Semestre, Ano, prédio e número da sala.
-- c. Exemplo: SELECT * FROM dbo.return_instructor_location('Gustafsson');
CREATE OR ALTER FUNCTION dbo.return_instructor_location
(
    @nome_instrutor VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS Nome_Instrutor,
        c.title AS Curso_Ministrado,
        s.semester AS Semestre_Curso,
        s.year AS Ano_Curso,
        s.building AS Predio,
        s.room_number AS Numero_Sala
    FROM dbo.instructor i
    JOIN dbo.teaches t 
        ON i.ID = t.ID
    JOIN dbo.course c 
        ON t.course_id = c.course_id
    JOIN dbo.section s 
        ON t.course_id = s.course_id 
       AND t.sec_id = s.sec_id 
       AND t.semester = s.semester 
       AND t.year = s.year
    WHERE i.name = @nome_instrutor
);
