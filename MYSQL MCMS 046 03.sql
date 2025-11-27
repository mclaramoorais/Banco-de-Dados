-- 1.3 E-commerce
-- Desenvolva uma modelagem completa para um sistema de e-commerce com as seguintes características:
-- O sistema gerencia produtos, clientes, pedidos e pagamentos
-- Produtos possuem código, nome, descrição, preço, estoque e categoria
-- Produtos podem pertencer a múltiplas categorias organizadas hierarquicamente
-- Clientes possuem dados pessoais, endereços de entrega e dados de pagamento
-- Pedidos contêm data, status, valor total, método de pagamento e itens comprados
-- Cada item de pedido possui quantidade, preço unitário e subtotal
-- O sistema deve manter histórico de preços dos produtos
-- O sistema deve gerenciar promoções e cupons de desconto
-- O sistema deve controlar o estoque e gerar alertas quando produtos estão acabando
-- Clientes podem avaliar produtos com notas e comentários.


CREATE DATABASE IF NOT EXISTS ecommerce_db
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

CREATE TABLE ENDERECO_CLIENTE (
    Id_endereco INT,
    Rua VARCHAR(255),
    Numero VARCHAR(50),
    Complemento_ VARCHAR(255),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    Id_cliente INT,
    Nome VARCHAR(255),
    E_mail VARCHAR(255),
    Telefone VARCHAR(20),
    CPF VARCHAR(20),
    Data_nascimento DATE,
    FK_PEDIDO_Id_pedido INT,
    PRIMARY KEY (Id_endereco, Id_cliente)
);

CREATE TABLE PRODUTO (
    Id_produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao VARCHAR(1000),
    Preco_atual DECIMAL(10,2),
    Estoque INT
);

CREATE TABLE CATEGORIA (
    Id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    FK_PRODUTO_Id_produto INT,
    CONSTRAINT FK_CATEGORIA_2 FOREIGN KEY (FK_PRODUTO_Id_produto)
        REFERENCES PRODUTO (Id_produto)
        ON DELETE RESTRICT
);

CREATE TABLE PEDIDO_PAGAMENTO_CUPOM_DE_DESCONTO (
    Id_pedido INT,
    Data DATE,
    Status VARCHAR(100),
    Valor_total DECIMAL(10,2),
    Metodo_pagamento VARCHAR(100),
    Id_cliente INT,
    Id_pagamento INT,
    Data_pagamento DATE,
    Valor DECIMAL(10,2),
    Forma_pagamento VARCHAR(100),
    Status_pagamento VARCHAR(100),
    Id_cupom INT,
    Codigo INT,
    Valor_desconto DECIMAL(10,2),
    Data_validade DATE,
    PRIMARY KEY (Id_pedido, Id_pagamento, Id_cupom)
);

CREATE TABLE ITEM_PEDIDO (
    Id_item INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT,
    Preco_unitario DECIMAL(10,2),
    Subtotal DECIMAL(10,2),
    Id_pedido INT,
    Id_produto INT
);


CREATE TABLE HISTORICO (
    Id_historico INT AUTO_INCREMENT PRIMARY KEY,
    Data_inicio DATE,
    Data_fim DATE,
    Preco DECIMAL(10,2),
    Id_produto_ INT
);

CREATE TABLE AVALIACAO (
    Id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    Nota DECIMAL(3,1),
    Comentario VARCHAR(1000),
    Data_avaliacao DATE,
    Id_cliente INT,
    Id_produto INT,
    FK_PRODUTO_Id_produto INT,
    CONSTRAINT FK_AVALIACAO_2 FOREIGN KEY (FK_PRODUTO_Id_produto)
        REFERENCES PRODUTO (Id_produto)
        ON DELETE RESTRICT
);

CREATE TABLE CONTEM (
    FK_PEDIDO_Id_pedido INT,
    FK_PEDIDO_Id_pagamento INT,
    FK_PEDIDO_Id_cupom INT,
    FK_ITEM_Id_item INT,
    CONSTRAINT FK_CONTEM_1 FOREIGN KEY (FK_PEDIDO_Id_pedido, FK_PEDIDO_Id_pagamento, FK_PEDIDO_Id_cupom)
        REFERENCES PEDIDO_PAGAMENTO_CUPOM_DE_DESCONTO (Id_pedido, Id_pagamento, Id_cupom)
        ON DELETE RESTRICT,
    CONSTRAINT FK_CONTEM_2 FOREIGN KEY (FK_ITEM_Id_item)
        REFERENCES ITEM_PEDIDO (Id_item)
        ON DELETE RESTRICT
);

CREATE TABLE E_PARTE (
    FK_ITEM_Id_item INT,
    FK_PRODUTO_Id_produto INT,
    CONSTRAINT FK_E_PARTE_1 FOREIGN KEY (FK_ITEM_Id_item)
        REFERENCES ITEM_PEDIDO (Id_item)
        ON DELETE RESTRICT,
    CONSTRAINT FK_E_PARTE_2 FOREIGN KEY (FK_PRODUTO_Id_produto)
        REFERENCES PRODUTO (Id_produto)
        ON DELETE RESTRICT
);

CREATE TABLE TEM (
    FK_PRODUTO_Id_produto INT,
    FK_HISTORICO_Id_historico INT,
    CONSTRAINT FK_TEM_1 FOREIGN KEY (FK_PRODUTO_Id_produto)
        REFERENCES PRODUTO (Id_produto)
        ON DELETE RESTRICT,
    CONSTRAINT FK_TEM_2 FOREIGN KEY (FK_HISTORICO_Id_historico)
        REFERENCES HISTORICO (Id_historico)
        ON DELETE RESTRICT
);