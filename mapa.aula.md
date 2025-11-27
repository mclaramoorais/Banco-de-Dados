# 🧠 Mapa Mental – Comandos e Funções do MySQL (BANCO II)

## 1️⃣ TRANSAÇÕES
- **BEGIN / START TRANSACTION**
  - Inicia uma transação (modo seguro de execução)
  - Exemplo:
    ```sql
    START TRANSACTION;
    UPDATE contas SET saldo = saldo - 200 WHERE id = 1;
    UPDATE contas SET saldo = saldo + 200 WHERE id = 2;
    COMMIT;
    ```
- **COMMIT**
  - Confirma todas as operações da transação
  - Exemplo:
    ```sql
    COMMIT;
    ```
- **ROLLBACK**
  - Desfaz todas as alterações não confirmadas
  - Exemplo:
    ```sql
    ROLLBACK;
    ```
- **SAVEPOINT nome**
  - Cria um ponto de restauração intermediário
  - Exemplo:
    ```sql
    SAVEPOINT etapa1;
    ```
- **ROLLBACK TO nome**
  - Retorna até um ponto específico
  - Exemplo:
    ```sql
    ROLLBACK TO etapa1;
    ```
- **SET TRANSACTION ISOLATION LEVEL**
  - Define o nível de isolamento (controle de concorrência)
  - Exemplo:
    ```sql
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    ```

---

## 2️⃣ VISÕES (VIEWS)
- **CREATE VIEW**
  - Cria uma tabela virtual com base em uma consulta
  - Exemplo:
    ```sql
    CREATE VIEW vw_vendas AS 
    SELECT cliente, SUM(total) AS total 
    FROM vendas GROUP BY cliente;
    ```
- **SELECT * FROM view**
  - Consulta uma visão
  - Exemplo:
    ```sql
    SELECT * FROM vw_vendas;
    ```
- **ALTER VIEW**
  - Modifica uma visão existente
  - Exemplo:
    ```sql
    ALTER VIEW vw_vendas AS 
    SELECT cliente, COUNT(*) AS qtd 
    FROM vendas GROUP BY cliente;
    ```
- **DROP VIEW**
  - Remove uma visão
  - Exemplo:
    ```sql
    DROP VIEW vw_vendas;
    ```

---

## 3️⃣ GATILHOS (TRIGGERS)
- **CREATE TRIGGER nome_timing_event**
  - Cria uma ação automática antes ou depois de um evento
  - Exemplo:
    ```sql
    CREATE TRIGGER log_vendas
    AFTER INSERT ON vendas
    FOR EACH ROW
    INSERT INTO logs(acao, data) VALUES ('Nova venda', NOW());
    ```
- **BEFORE INSERT / UPDATE / DELETE**
  - Executa antes da ação ocorrer
  - Exemplo:
    ```sql
    CREATE TRIGGER validar_preco
    BEFORE INSERT ON produtos
    FOR EACH ROW
    IF NEW.preco < 0 THEN SET NEW.preco = 0; END IF;
    ```
- **AFTER INSERT / UPDATE / DELETE**
  - Executa após o evento ocorrer
  - Exemplo:
    ```sql
    CREATE TRIGGER atualizar_log
    AFTER UPDATE ON clientes
    FOR EACH ROW
    INSERT INTO log_acoes VALUES (NOW(), 'Atualização de cliente');
    ```
- **DROP TRIGGER nome**
  - Remove um gatilho
  - Exemplo:
    ```sql
    DROP TRIGGER atualizar_log;
    ```

---

## 4️⃣ PROCEDURES (PROCEDIMENTOS)
- **CREATE PROCEDURE nome()**
  - Cria um bloco de comandos armazenado no servidor
  - Exemplo:
    ```sql
    DELIMITER //
    CREATE PROCEDURE listar_clientes()
    BEGIN
      SELECT * FROM clientes;
    END //
    DELIMITER ;
    ```
- **CALL nome()**
  - Executa uma procedure
  - Exemplo:
    ```sql
    CALL listar_clientes();
    ```
- **CREATE PROCEDURE nome(param)**
  - Cria procedure com parâmetros de entrada
  - Exemplo:
    ```sql
    DELIMITER //
    CREATE PROCEDURE buscar_cliente(IN id_cliente INT)
    BEGIN
      SELECT * FROM clientes WHERE id = id_cliente;
    END //
    DELIMITER ;
    ```
- **OUT / INOUT**
  - Define parâmetros de saída e bidirecionais
  - Exemplo:
    ```sql
    CREATE PROCEDURE somar(IN a INT, IN b INT, OUT resultado INT)
    BEGIN
      SET resultado = a + b;
    END;
    ```
- **DROP PROCEDURE nome**
  - Remove uma procedure
  - Exemplo:
    ```sql
    DROP PROCEDURE listar_clientes;
    ```

---

## 5️⃣ ÍNDICES (INDEXAÇÃO)
- **CREATE INDEX**
  - Cria um índice para acelerar consultas
  - Exemplo:
    ```sql
    CREATE INDEX idx_nome ON clientes(nome);
    ```
- **CREATE UNIQUE INDEX**
  - Cria índice que impede duplicações
  - Exemplo:
    ```sql
    CREATE UNIQUE INDEX idx_cpf ON clientes(cpf);
    ```
- **CREATE INDEX nome ON tabela (col1, col2)**
  - Cria um índice composto para múltiplas colunas
  - Exemplo:
    ```sql
    CREATE INDEX idx_nome_cidade ON clientes(nome, cidade);
    ```
- **SHOW INDEX FROM tabela**
  - Lista os índices existentes
  - Exemplo:
    ```sql
    SHOW INDEX FROM clientes;
    ```
- **DROP INDEX nome ON tabela**
  - Remove um índice
  - Exemplo:
    ```sql
    DROP INDEX idx_nome ON clientes;
    ```
