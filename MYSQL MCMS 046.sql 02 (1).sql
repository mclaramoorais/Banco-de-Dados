-- 1.2 Biblioteca
-- Desenvolva uma modelagem completa para um sistema de biblioteca com as seguintes características:
-- A biblioteca possui livros, revistas e materiais audiovisuais
-- Cada item possui um código único, título, ano de publicação e localização na estante
-- Livros possuem ISBN, autor(es), editora e número de páginas
-- Revistas possuem ISSN, periodicidade e edição
-- Materiais audiovisuais possuem tipo (DVD, CD, etc.), duração e diretor/artista
-- Modelagem de Dados Banco de Dados
-- Usuários podem emprestar itens por um período determinado
-- O sistema deve controlar datas de empréstimo, devolução prevista e devolução efetiva
-- Usuários atrasados na devolução recebem multas
-- O sistema deve permitir reservas de itens que estão emprestados

CREATE DATABASE biblioteca;
USE BIBLIOTECA;

CREATE TABLE EMPRESTIMO (
    Id_emprestimo INT PRIMARY KEY,
    data_emprestimo DATE,
    data_prevista DATE,
    data_devolucao DATE,
    multa DECIMAL(10, 2)
);

CREATE TABLE RESERVA (
    Id_reserva INT PRIMARY KEY,
    data_reserva DATE
);

CREATE TABLE USUARIO (
    Id_usuario INT PRIMARY KEY,
    Nome VARCHAR(255),
    E_mail VARCHAR(255),
    FK_EMPRESTIMO_Id_emprestimo INT,
    FK_RESERVA_Id_reserva INT,
    CONSTRAINT FK_USUARIO_2 FOREIGN KEY (FK_EMPRESTIMO_Id_emprestimo)
        REFERENCES EMPRESTIMO (Id_emprestimo)
        ON DELETE RESTRICT,
    CONSTRAINT FK_USUARIO_3 FOREIGN KEY (FK_RESERVA_Id_reserva)
        REFERENCES RESERVA (Id_reserva)
        ON DELETE RESTRICT
);

CREATE TABLE ITEM_REVISTA_LIVRO_AUDIOVISUAIS (
    Id_item INT,
    Titulo VARCHAR(255),
    Ano_publicacao DATE,
    Localizacao VARCHAR(255),
    Issn INT,
    Periodicidade INT,
    Edicao INT,
    Isbn INT,
    Editora VARCHAR(255),
    Num_paginas INT,
    FK_EMPRESTIMO_Id_emprestimo INT,
    Tipo VARCHAR(255),
    Duracao VARCHAR(255),
    Diretor_artista VARCHAR(255),
    Id_audiovisual INT,
    FK_RESERVA_Id_reserva INT,
    PRIMARY KEY (Id_item, Issn, Isbn, Id_audiovisual),
    CONSTRAINT FK_ITEM_REVISTA_LIVRO_AUDIOVISUAIS_2 FOREIGN KEY (FK_EMPRESTIMO_Id_emprestimo)
        REFERENCES EMPRESTIMO (Id_emprestimo)
        ON DELETE RESTRICT,
    CONSTRAINT FK_ITEM_REVISTA_LIVRO_AUDIOVISUAIS_3 FOREIGN KEY (FK_RESERVA_Id_reserva)
        REFERENCES RESERVA (Id_reserva)
        ON DELETE RESTRICT
);
