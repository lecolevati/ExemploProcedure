/*
Aluno
|Codigo_aluno|Nome|

Atividade
|Codigo|Descrição|IMC|

Atividade
codigo      descricao                           imc
----------- ----------------------------------- --------
1           Corrida + Step                       18.5
2           Biceps + Costas + Pernas             24.9
3           Esteira + Biceps + Costas + Pernas   29.9
4           Bicicleta + Biceps + Costas + Pernas 34.9
5           Esteira + Bicicleta                  39.9                                                                                                                                                                    

Atividadesaluno
|Codigo_aluno|Altura|Peso|IMC|Atividade|
*/

create database academia
go
use academia

create table aluno(
codigo int not null primary key,
nome varchar(100))

create table atividade(
codigo int not null primary key,
descricao varchar(200),
imc decimal(7,2))

create table atividadesaluno(
codigo_aluno int not null primary key,
altura decimal(7,2),
peso decimal(7,2),
imc decimal(7,2),
atividade int
foreign key (codigo_aluno) references aluno(codigo),
foreign key (atividade) references atividade(codigo))

insert into atividade values 
(1,'Corrida + Step',18.5),
(2,'Biceps + Costas + Pernas',24.9),
(3,'Esteira + Biceps + Costas + Pernas',29.9),
(4,'Bicicleta + Biceps + Costas + Pernas',34.9),
(5,'Esteira + Bicicleta',39.9)

select * from aluno
select * from atividade
select * from atividadesaluno

CREATE PROCEDURE sp_alunoatividades(@codigoaluno INT, @nomealuno VARCHAR(100), 
	@alt DECIMAL(7,2), @peso DECIMAL(7,2), @codaluno INT OUTPUT)
AS
	DECLARE @imcaluno DECIMAL(7,2),
			@atividade INT,
			@ultimocodigoaluno INT
	SET @imcaluno = @peso / POWER(@alt,2)
	IF (@imcaluno < 18.5)
	BEGIN
		SET @atividade = 1
	END
	ELSE
	BEGIN
		IF (@imcaluno >= 18.5 AND @imcaluno < 25)
		BEGIN
			SET @atividade = 2
		END
		ELSE
		BEGIN
			IF (@imcaluno >= 25 AND @imcaluno < 30)
			BEGIN
				SET @atividade = 3
			END
			ELSE
			BEGIN
				IF (@imcaluno >= 30 AND @imcaluno < 35)
				BEGIN
					SET @atividade = 4
				END
				ELSE
				BEGIN
					SET @atividade = 5
				END
			END		
		END
	END
	IF (@codigoaluno IS NULL AND @nomealuno IS NULL)
	BEGIN
		RAISERROR ('Codigo ou Nome devem ser inseridos',16,1)
	END
	ELSE
	BEGIN
		IF(@codigoaluno IS NULL)
		BEGIN
			SET @ultimocodigoaluno = (SELECT CASE WHEN (MAX(codigo) IS NULL) THEN 0 ELSE MAX(codigo) END FROM Aluno)
			SET @codaluno = @ultimocodigoaluno + 1
			SET @codigoaluno = @codaluno
			INSERT INTO aluno VALUES (@codaluno, @nomealuno)
		END
		IF ((SELECT COUNT(*) FROM atividadesaluno WHERE codigo_aluno = @codigoaluno) > 0)
		BEGIN
			DELETE atividadesaluno WHERE codigo_aluno = @codigoaluno
		END
		INSERT INTO atividadesaluno VALUES 
		(@codigoaluno, @alt, @peso, @imcaluno, @atividade)
		IF (@codaluno IS NULL)
		BEGIN
			SET @codaluno = @codigoaluno
		END
	END