-- 1) EXPLIQUE OS SEGUINTES CONCEITO
-- A) BANCO DE DADOS: É uma coleção de dados operacionais armazenados, usados pelos sistemas de aplicação de uma determinada organização. 

-- B) SISTEMA DE GERENCIAMENTO DE BANCO DE DADOS (SGBD): É o software responsável pelo gerenciamento dos dados do banco de dados.

-- C) MODELO RELACIONAL: É uma forma de organizar os dados em tabelas.

-- D) CHAVE PRIMÁRIA E CHAVE ESTRANGEIRA: Chave primária é um identificador único para cada linha de uma tabela. Chave estrangeira é uma coluna que faz referência á chave primária de outra tabela.

-- E) INTEGRIDADE REFERENCIAL: é um conjunto de regras que garantem que os dados de um banco sejam consistentes, precisos e armazenados de forma adequada.

-- 2) QUAL A DIFERENÇA ENTRE UM BANCO DE DADOS RELACIONAL E UM BANCO DE DADOS NoSQL? Os bancos de dados relacionais armazenam dados de acordo com esquemas específicos. O NoSQL permite que os dados seja, armazenados usando qualquer estrutura necessária.

-- 3) 

CREATE DATABASE AGENDA; 
show databases;
USE AGENDA;

CREATE TABLE CONTATOS2(
nome_sobrenome varchar(100) not null primary key,
apelido varchar(100) not null,
relação enum('amigo', 'parente', 'comercial', 'empresarial', 'conjuge'),
statu enum('ativo', 'desativado'),
frequência_contato enum('diário', 'semanal', 'anual', 'raramente'),
telefones enum('fixo', 'celular', 'email'),
contatos_redes enum('whatsapp', 'twitter', 'instagram', 'facebook'),
cidade varchar(100),
estado varchar(100),
país varchar(100),
data_última_conversa varchar(100),
observação varchar(100) default 'não há observação'
);


SHOW TABLES;
DESCRIBE TABLES;

INSERT INTO CONTATOS2 (nome_sobrenome, apelido, relação, statu, frequência_contato, telefones, contatos_redes, cidade, estado, país, data_última_conversa, observação )values ('maria clara', 'clarinha', 'parente', 'ativo', 'diário', 'celular', 'whatsapp', 'recife', 'pernambuco', 'brasil', '2025-03-18', 'não há observação');
INSERT INTO CONTATOS2 (nome_sobrenome, apelido, relação, statu, frequência_contato, telefones, contatos_redes, cidade, estado, país, data_última_conversa, observação )values('vitor daniel', 'dani', 'amigo', 'ativo', 'diário', 'celular', 'whatsapp', 'recife', 'pernambuco', 'brasil', '2025-03-18', 'não há observação');
INSERT INTO CONTATOS2 (nome_sobrenome, apelido, relação, statu, frequência_contato, telefones, contatos_redes, cidade, estado, país, data_última_conversa, observação )values('luiz felipe', 'felipe', 'amigo', 'ativo', 'diário', 'celular', 'whatsapp', 'recife', 'pernambuco', 'brasil', '2025-03-18', 'não há observação');

SELECT*FROM CONTATOS2;



-- 4) AGORA RESPONDA COM BASE NO BANCO DE DADOS CRIADO NO EXERCÍCIO 3:
-- A) QUAL É O NOME DO BANCO DE DADOS? Agenda.
-- B) QUAIS SÃO AS TABELAS? Contatos2.
-- C) QUAIS SÃO AS COLUNAS? Nome_sobrenome, apelido, relação, statu, frequência_contato, telefones, contatod_redes, cidade, estado, país, data_última_conversa, observação.
-- D) QUAIS SÃO OS TIPOS DE DADOS UTILIZADOS NO SEU BANCO DE DADOS? Varchar e Enum.
-- E) AS COLUNAS POSSUEM RESTRIÇÕES? SE SIM, QUAIS? Not null e primary key. 
-- F) HÁ ALGUM TIPO CAMPO IDENTIFICADOR? SE SIM, QUAIS? Nome_sobrenome é o identificador.


-- 5) 

create database mundos_perdidos;

use mundos_perdidos;

create table itens_magicos(
id INT auto_increment primary key,
nome varchar(100) not null,
raridade varchar(50) not null,
poder INT NOT NULL
);

ALTER TABLE itens_magicos
add column nivel_minimo varchar(100);

SHOW TABLES;

ALTER TABLE itens_magicos
modify poder decimal(5,2);

ALTER TABLE itens_magicos
rename column raridade to categoria;

CREATE TABLE encantamentos (
id int primary key auto_increment not null,
item_id int,
foreign key (item_id) references itens_magicos (id),
descrição varchar(255),
custo_mana int
);

DESCRIBE encantamentos;



-- ALUNA: MARIA CLARA DE MORAIS SILVA