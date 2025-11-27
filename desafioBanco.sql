-- ex 1 (criando o banco)
-- 1)
CREATE DATABASE Clinica;
USE Clinica;

-- 2)
CREATE TABLE Ambulatorios (
    nroa INT PRIMARY KEY,
    andar NUMERIC(3) NOT NULL,
    capacidade SMALLINT
);

CREATE TABLE Medicos (
    codm INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    FOREIGN KEY (nroa) REFERENCES Ambulatorios (nroa)
);

CREATE TABLE Pacientes (
    codp INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade CHAR(30),
    CPF NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL
);

CREATE TABLE Funcionarios (
    codf INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT,
    CPF NUMERIC(11) UNIQUE,
    cidade CHAR(30),
    salario NUMERIC(10),
    cargo VARCHAR(20)
);

CREATE TABLE Consultas (
    codm INT,
    codp INT,
    data DATE,
    hora TIME,
    PRIMARY KEY (codm, codp, data),
    FOREIGN KEY (codp) REFERENCES Pacientes (codp),
    FOREIGN KEY (codm) REFERENCES Medicos (codm)
);

-- 3)
ALTER TABLE Funcionarios ADD COLUMN (nroa INT);

-- 4)
CREATE UNIQUE INDEX idx_med_cpf ON Medicos (CPF);
CREATE INDEX idx_pac_doenca ON Pacientes (doenca);

-- 5)
DROP INDEX idx_pac_doenca ON Pacientes;

-- 6)
ALTER TABLE Funcionarios DROP COLUMN cargo, DROP COLUMN nroa;

-- populando tabelas

INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES
    (1, 1, 30),
    (2, 1, 50),
    (3, 2, 40),
    (4, 2, 25),
    (5, 2, 55);

INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES
    (1, 'Joao', 40, 'ortopedia', '10000100000', 'Florianopolis', 1),
    (2, 'Maria', 42, 'traumatologia', '10000110000', 'Blumenau', 2),
    (3, 'Pedro', 51, 'pediatria', '11000100000', 'São José', 2),
    (4, 'Carlos', 28, 'ortopedia', '11000110000', 'Joinville', NULL),
    (5, 'Marcia', 33, 'neurologia', '11000111000', 'Biguaçu', 3);

INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES
    (1, 'Ana', 20, 'Florianopolis', '20000200000', 'gripe'),
    (2, 'Paulo', 24, 'Palhoca', '20000220000', 'fratura'),
    (3, 'Lucia', 30, 'Biguaçu', '22000200000', 'tendinite'),
    (4, 'Carlos', 28, 'Joinville', '11000110000', 'sarampo');

INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES
    (1, 'Rita', 32, 'Sao Jose', 1200, '20000100000'),
    (2, 'Maria', 55, 'Palhoca', 1220, '30000110000'),
    (3, 'Caio', 45, 'Florianopolis', 1100, '41000100000'),
    (4, 'Carlos', 44, 'Florianopolis', 1200, '51000110000'),
    (5, 'Paula', 33, 'Florianopolis', 2500, '61000111000');

INSERT INTO Consultas (codm, codp, data, hora) VALUES
    (1, 1, '2006-06-12', '14:00'),
    (1, 4, '2006-06-13', '10:00'),
    (2, 1, '2006-06-13', '09:00'),
    (2, 2, '2006-06-13', '11:00'),
    (2, 3, '2006-06-14', '14:00'),
    (2, 4, '2006-06-14', '17:00'),
    (3, 1, '2006-06-19', '18:00'),
    (3, 3, '2006-06-12', '10:00'),
    (3, 4, '2006-06-19', '13:00'),
    (4, 4, '2006-06-20', '13:00'),
    (4, 4, '2006-06-22', '19:30');

-- ex2 (Atualizações)

-- 1)
UPDATE Pacientes 
SET cidade = 'ilhota'
WHERE nome = 'Paulo';

-- 2)
UPDATE Consultas 
SET data = '2006-07-04', hora = '12:00'
WHERE codm = 1 AND codp = 4;

-- 3)
UPDATE Pacientes 
SET idade = 21 AND doenca = 'cancer'
WHERE nome = 'Ana';

-- 4)
UPDATE Consultas 
SET data = '2006-06-19', hora = '14:30'
WHERE codm = 3 AND codp = 4;

-- 6)
DELETE FROM Consultas 
WHERE hora = '19:30';

-- FKs para CASCADE
SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Consultas'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY';

ALTER TABLE Consultas DROP FOREIGN KEY consultas_ibfk_2;

ALTER TABLE Consultas 
ADD FOREIGN KEY (codp) REFERENCES Pacientes (codp) ON DELETE CASCADE;

-- 7)
DELETE FROM Pacientes 
WHERE idade < 10 OR doenca = 'cancer';

-- 8)
DELETE FROM Medicos 
WHERE cidade = 'Biguaçu' OR cidade = 'Palhoca';

SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Medicos' 
  AND CONSTRAINT_TYPE = 'FOREIGN KEY';

ALTER TABLE Medicos DROP FOREIGN KEY medicos_ibfk_1;

ALTER TABLE Medicos 
ADD FOREIGN KEY (nroa) REFERENCES Ambulatorios (nroa) ON DELETE CASCADE;

-- ex3 (Consultas)

USE Clinica;

-- 1)
SELECT nome, cpf
FROM Medicos
WHERE idade < 40 OR especialidade != 'traumatologia';

-- 2)
SELECT *
FROM Consultas
WHERE hora BETWEEN '12:01' AND '18:00'
  AND data > '2006-06-19';

-- 3)
SELECT nome, idade
FROM Pacientes
WHERE cidade != 'Florianopolis';

-- 4)
SELECT hora
FROM Consultas
WHERE data BETWEEN '2006-06-14' AND '2006-06-20';

-- 5)
SELECT nome, idade * 12 AS idade_meses
FROM Pacientes;

-- 6)
SELECT nome, cidade
FROM Funcionarios;

-- 7)
SELECT MIN(salario), MAX(salario)
FROM Funcionarios
WHERE cidade = 'Florianopolis';

-- 10)
SELECT MAX(hora)
FROM Consultas
WHERE data = '2006-06-13';

-- 11)
SELECT AVG(idade) AS media_idade_medicos,
       COUNT(DISTINCT nroa) AS total_ambulatorios_atendidos
FROM Medicos;

-- 12)
SELECT codf, nome, salario - salario * 0.20 AS salario_liquido
FROM Funcionarios;

-- 13)
SELECT nome
FROM Funcionarios
WHERE nome LIKE '%a';

-- 14)
SELECT nome, cpf
FROM Funcionarios
WHERE cpf NOT LIKE '%00000%';

-- 15)
SELECT nome, especialidade
FROM Medicos
WHERE nome LIKE '_O%O';

-- 16)
SELECT codp, nome
FROM Pacientes
WHERE idade > 25 AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo');
        
-- ex 4 (buscas através de um produto, de uma junção e de uma junção natural, quando possível)----

-- 1) 
-- PRODUTO CARTESIANO
SELECT m.nome, m.cpf
FROM medicos m, pacientes p
WHERE m.cpf = p.cpf;

-- JUNÇÃO
SELECT m.nome, m.cpf
FROM medicos m
INNER JOIN pacientes p ON m.cpf = p.cpf;

-- JUNÇÃO NATURAL
SELECT nome, cpf
FROM medicos
NATURAL JOIN pacientes;

-- 2) 
-- PRODUTO CARTESIANO
SELECT f.codf, f.nome, m.codm, m.nome
FROM funcionarios f, medicos m
WHERE f.cidade = m.cidade;

-- JUNÇÃO
SELECT f.codf, f.nome, m.codm, m.nome
FROM funcionarios f
INNER JOIN medicos m ON f.cidade = m.cidade;

-- JUNÇÃO NATURAL
SELECT f.codf, f.nome, m.codm, m.nome
FROM funcionarios f
NATURAL JOIN medicos m;

-- 3) 
-- PRODUTO CARTESIANO
SELECT DISTINCT p.codp, p.nome
FROM pacientes p, consultas c
WHERE p.codp = c.codp 
  AND EXTRACT(HOUR FROM c.hora) > 14;

-- JUNÇÃO
SELECT DISTINCT p.codp, p.nome
FROM pacientes p
INNER JOIN consultas c ON p.codp = c.codp
WHERE EXTRACT(HOUR FROM c.hora) > 14;

-- 4) 
-- PRODUTO CARTESIANO
SELECT DISTINCT a.nroa, a.andar
FROM ambulatorios a, medicos m
WHERE a.nroa = m.nroa 
  AND m.especialidade = 'Ortopedia';

-- JUNÇÃO
SELECT DISTINCT a.nroa, a.andar
FROM ambulatorios a
INNER JOIN medicos m ON a.nroa = m.nroa
WHERE m.especialidade = 'Ortopedia';

-- JUNÇÃO NATURAL
SELECT DISTINCT nroa, andar
FROM ambulatorios
NATURAL JOIN medicos
WHERE especialidade = 'Ortopedia';

-- 5) 

-- PRODUTO CARTESIANO
SELECT DISTINCT p.nome, p.cpf
FROM pacientes p, consultas c
WHERE p.codp = c.codp 
  AND c.data BETWEEN '2006-06-14' AND '2006-06-16';

-- JUNÇÃO
SELECT DISTINCT p.nome, p.cpf
FROM pacientes p
INNER JOIN consultas c ON p.codp = c.codp
WHERE c.data BETWEEN '2006-06-14' AND '2006-06-16';

-- 6) 
-- PRODUTO CARTESIANO
SELECT DISTINCT m.nome, m.idade
FROM medicos m, pacientes p, consultas c
WHERE m.codm = c.codm 
  AND p.codp = c.codp 
  AND p.nome = 'Ana';

-- JUNÇÃO
SELECT DISTINCT m.nome, m.idade
FROM medicos m
INNER JOIN consultas c ON m.codm = c.codm
INNER JOIN pacientes p ON p.codp = c.codp
WHERE p.nome = 'Ana';

-- 7) 
-- PRODUTO CARTESIANO
SELECT DISTINCT m2.codm, m2.nome
FROM medicos m1, medicos m2, consultas c
WHERE m1.nome = 'Pedro'
  AND m1.nroa = m2.nroa
  AND m2.codm = c.codm
  AND c.data = '2006-06-14';

-- JUNÇÃO
SELECT DISTINCT m2.codm, m2.nome
FROM medicos m1
INNER JOIN medicos m2 ON m1.nroa = m2.nroa
INNER JOIN consultas c ON m2.codm = c.codm
WHERE m1.nome = 'Pedro'
  AND c.data = '2006-06-14';

-- 8) 
-- PRODUTO CARTESIANO
SELECT DISTINCT p.nome, p.cpf, p.idade
FROM pacientes p, medicos m, consultas c
WHERE p.codp = c.codp
  AND m.codm = c.codm
  AND m.especialidade = 'Ortopedia'
  AND c.data < '2006-06-16';

-- JUNÇÃO
SELECT DISTINCT p.nome, p.cpf, p.idade
FROM pacientes p
INNER JOIN consultas c ON p.codp = c.codp
INNER JOIN medicos m ON m.codm = c.codm
WHERE m.especialidade = 'Ortopedia'
  AND c.data < '2006-06-16';

-- 9) 
-- PRODUTO CARTESIANO
SELECT f2.nome, f2.salario
FROM funcionarios f1, funcionarios f2
WHERE f1.nome = 'Carlos'
  AND f1.cidade = f2.cidade
  AND f2.salario > f1.salario;

-- JUNÇÃO
SELECT f2.nome, f2.salario
FROM funcionarios f1
INNER JOIN funcionarios f2 ON f1.cidade = f2.cidade
WHERE f1.nome = 'Carlos'
  AND f2.salario > f1.salario;

-- 10) 
SELECT a.*, m.codm, m.nome
FROM ambulatorios a
LEFT JOIN medicos m ON a.nroa = m.nroa;

-- 11) 
SELECT m.cpf AS cpf_medico, m.nome AS nome_medico,
       p.cpf AS cpf_paciente, p.nome AS nome_paciente,
       c.data
FROM medicos m
LEFT JOIN consultas c ON m.codm = c.codm
LEFT JOIN pacientes p ON c.codp = p.codp;

-- ex 5 subconsultas ---

-- SUBconsultas ANY/ALL
-- 1)
SELECT nroa, andar
FROM ambulatorios
WHERE capacidade > ANY (
    SELECT capacidade 
    FROM ambulatorios
);

-- 2) 
SELECT nome, idade
FROM medicos
WHERE codm = ANY (
    SELECT codm 
    FROM consultas 
    WHERE codp = (
        SELECT codp 
        FROM pacientes 
        WHERE nome = 'Ana'
    )
);

-- 3) 
SELECT nome, idade
FROM medicos m1
WHERE idade <= ALL (
    SELECT idade 
    FROM medicos
);

-- 4) 
SELECT nome, cpf
FROM pacientes
WHERE codp IN (
    SELECT codp 
    FROM consultas c1
    WHERE hora < ALL (
        SELECT hora 
        FROM consultas 
        WHERE data = '2006-11-12'
    )
);

-- 5) 
SELECT nome, cpf
FROM medicos
WHERE nroa NOT IN (
    SELECT nroa 
    FROM ambulatorios 
    WHERE capacidade > ALL (
        SELECT capacidade 
        FROM ambulatorios 
        WHERE andar = 2
    )
);

-- SUBconsultas EXISTS
-- 1) 
SELECT nome, cpf
FROM medicos m
WHERE EXISTS (
    SELECT 1 
    FROM pacientes p 
    WHERE p.cpf = m.cpf
);

-- 2) 
SELECT nome, idade
FROM medicos m
WHERE EXISTS (
    SELECT 1 
    FROM consultas c 
    WHERE c.codm = m.codm 
    AND EXISTS (
        SELECT 1 
        FROM pacientes p 
        WHERE p.codp = c.codp 
        AND p.nome = 'Ana'
    )
);

-- 3) 
SELECT nroa
FROM ambulatorios a1
WHERE NOT EXISTS (
    SELECT 1 
    FROM ambulatorios a2 
    WHERE a2.capacidade > a1.capacidade
);

-- 4) 
SELECT nome, cpf
FROM medicos m
WHERE NOT EXISTS (
    SELECT codp 
    FROM pacientes p 
    WHERE NOT EXISTS (
        SELECT 1 
        FROM consultas c 
        WHERE c.codm = m.codm 
        AND c.codp = p.codp
    )
);

-- 5)
SELECT nome, cpf
FROM medicos m
WHERE especialidade = 'Ortopedia'
AND NOT EXISTS (
    SELECT codp 
    FROM pacientes p 
    WHERE p.cidade = 'Florianopolis'
    AND NOT EXISTS (
        SELECT 1 
        FROM consultas c 
        WHERE c.codm = m.codm 
        AND c.codp = p.codp
    )
);

-- SUBconsultas na cláusula FROM
-- 1) 
SELECT c.*
FROM consultas c,
     (SELECT codm FROM medicos WHERE nome = 'Maria') AS med_maria
WHERE c.codm = med_maria.codm;

-- 2) 
SELECT p.codp, p.nome
FROM pacientes p,
     (SELECT DISTINCT codp FROM consultas WHERE EXTRACT(HOUR FROM hora) > 14) AS cons_tarde
WHERE p.codp = cons_tarde.codp;

-- 3) 
SELECT p.nome, p.cidade
FROM pacientes p,
     (SELECT DISTINCT c.codp
      FROM consultas c,
           (SELECT codm FROM medicos WHERE especialidade = 'Ortopedia') AS med_orto
      WHERE c.codm = med_orto.codm) AS pac_orto
WHERE p.codp = pac_orto.codp;

-- 4) 
SELECT p.nome, p.cpf
FROM pacientes p,
     (SELECT codp FROM pacientes WHERE cidade = 'Florianopolis') AS pac_floripa
WHERE p.codp = pac_floripa.codp
AND p.codp NOT IN (
    SELECT c.codp
    FROM consultas c,
         (SELECT codm FROM medicos WHERE nome = 'Joao') AS med_joao
    WHERE c.codm = med_joao.codm
);

-- ex 6 (ORDER BY e GROUP BY) ----
-- 1) 
SELECT *
FROM funcionarios
ORDER BY salario DESC, idade ASC
LIMIT 3;

-- 2)
SELECT m.nome, a.nroa, a.andar
FROM medicos m
INNER JOIN ambulatorios a ON m.nroa = a.nroa
ORDER BY a.nroa;

-- 3)
SELECT m.nome AS nome_medico, p.nome AS nome_paciente, c.data, c.hora
FROM medicos m
INNER JOIN consultas c ON m.codm = c.codm
INNER JOIN pacientes p ON c.codp = p.codp
ORDER BY c.data, c.hora;

-- 4)
SELECT idade, COUNT(*) AS total_medicos
FROM medicos
GROUP BY idade
ORDER BY idade;

-- 5) 
SELECT data, COUNT(*) AS total_consultas
FROM consultas
WHERE EXTRACT(HOUR FROM hora) > 12
GROUP BY data
ORDER BY data;

-- 6) 
SELECT andar, AVG(capacidade) AS media_capacidade
FROM ambulatorios
GROUP BY andar
ORDER BY andar;

-- 7) 
SELECT andar, AVG(capacidade) AS media_capacidade
FROM ambulatorios
GROUP BY andar
HAVING AVG(capacidade) >= 40
ORDER BY andar;

-- 8) 
SELECT m.nome, COUNT(*) AS total_consultas
FROM medicos m
INNER JOIN consultas c ON m.codm = c.codm
GROUP BY m.codm, m.nome
HAVING COUNT(*) > 1
ORDER BY total_consultas DESC;

-- atualizações
-- 1) 
UPDATE consultas 
SET hora = '19:00:00'
WHERE codp = (SELECT codp FROM pacientes WHERE nome = 'Ana');

-- 2) 
DELETE FROM pacientes
WHERE codp NOT IN (SELECT DISTINCT codp FROM consultas);

-- 3) 
UPDATE consultas 
SET data = '2006-11-21'
WHERE codm = (SELECT codm FROM medicos WHERE nome = 'Pedro')
AND hora < '12:00:00';

-- 4) 
UPDATE ambulatorios 
SET andar = (SELECT andar FROM ambulatorios WHERE nroa = 1),
    capacidade = (SELECT MAX(capacidade) * 2 FROM ambulatorios)
WHERE nroa = 4;

-- 5) 
INSERT INTO medicos (codm, nome, idade, especialidade, CPF, cidade, nroa)
SELECT 
    (SELECT MAX(codm) + 1 FROM medicos) AS novo_codm,
    f.nome,
    f.idade,
    (SELECT especialidade FROM medicos WHERE codm = 2) AS especialidade,
    f.CPF,
    f.cidade,
    (SELECT nroa FROM medicos WHERE codm = 2) AS nroa
FROM funcionarios f
WHERE f.codf = 3;