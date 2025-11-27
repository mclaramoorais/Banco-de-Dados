-- Lista de Exercícios III: Modelagem de Dados

-- 1.1 Lista de Tarefas
-- Desenvolva uma modelagem completa para um sistema simples de lista de tarefas com as
-- seguintes características:
-- O sistema permite que usuários criem múltiplas listas de tarefas
-- Cada tarefa possui um título, descrição, data de criação, data de vencimento e status
-- pendente, em andamento, concluída
-- As tarefas podem ser categorizadas (trabalho, pessoal, estudos, etc.)
-- Os usuários podem definir prioridades para as tarefas (baixa, média, alta)
-- O sistema deve registrar quando uma tarefa é concluída.alter.


CREATE DATABASE IF NOT EXISTS gerenciador_atividades;
USE gerenciador_atividades;
 CREATE TABLE lista (
    id_lista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    id_usuario INT
);
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE atividade_categoria (
    id_atividade INT,
    titulo VARCHAR(100),
    descricao TEXT,
    data_de_criacao DATE,
    data_de_vencimento DATE,
    status VARCHAR(50),
    prioridade ENUM('baixa', 'media', 'alta'),
    id_lista INT,
    id_categoria INT,
    nome_categoria VARCHAR(100),
    PRIMARY KEY (id_atividade, id_categoria),
    CONSTRAINT FK_atividade_lista FOREIGN KEY (id_lista)
        REFERENCES lista(id_lista)
        ON DELETE RESTRICT
);
CREATE TABLE contem (
    fk_lista_id_lista INT,
    fk_atividade_categoria_id_atividade INT,
    fk_atividade_categoria_id_categoria INT,
    CONSTRAINT FK_contem_1 FOREIGN KEY (fk_lista_id_lista)
        REFERENCES lista (id_lista)
        ON DELETE RESTRICT,
    CONSTRAINT FK_contem_2 FOREIGN KEY (fk_atividade_categoria_id_atividade, fk_atividade_categoria_id_categoria)
        REFERENCES atividade_categoria (id_atividade, id_categoria)
        ON DELETE RESTRICT
);


