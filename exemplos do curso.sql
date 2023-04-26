-- CRIAR TABELAS

CREATE DATABASE IF NOT EXISTS DB_NAME
DEFAULT CHARACTER SET = charset_name -- CARACTERES QUE O BANCO VAI SUPORTAR (EX: JAPONES, ACENTOS DO PORTUGUES)
-- Significa a tabela de caracteres que será utilizada no armazenamento de campos textos
DEFAULT COLLATE = collation_name
-- USAR CRIPTOGRAFIA
DEFAULT ENCRYPTION=  'Y';

CREATE DATABASE IF NOT EXISTS DB_NAME
DEFAULT CHARACTER SET utf8; 

-- CRIAR TABELA COM PRIMARY KEY
CREATE TABLE IF NOT EXISTS `db_name`.`sucos_vendas` 
(
`idsucos_vendas` INT NOT NULL,
PRIMARY KEY (`idsucos_vendas`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- IGNORE, REPLACE, AS

-- CRIAR TABELA COM LIKE
CREATE TEMPORARY TABLE IF NOT EXISTS tbl_name (
LIKE old_tbl_name );

-- EXERCÍCIO CRIAR TABELA
CREATE DATABASE IF NOT EXISTS vendas_sucos;
USE vendas_sucos; 
CREATE TABLE PRODUTOS
(codigo VARCHAR(10) NOT NULL,
descritor VARCHAR(100) NULL,
sabor VARCHAR(50) NULL,
tamanho VARCHAR(50) NULL,
embalagem VARCHAR(50) NULL,
preco_lista FLOAT NULL,
PRIMARY KEY(codigo)
);

CREATE TABLE VENDEDORES
(MATRICULA VARCHAR(5) NOT NULL, 
NOME VARCHAR(100) NULL, 
BAIRRO VARCHAR(50) NULL, 
COMISSAO FLOAT NULL, 
DATA_ADIMISSAO DATE NULL,
FERIAS BIT(1) NULL,
PRIMARY KEY (MATRICULA)
);

-- RENOMEAR COLUNA
ALTER TABLE VENDEDORES
RENAME COLUMN DATA_ADIMISSAO TO DATA_ADMISSAO; 

CREATE TABLE IF NOT EXISTS NOVA_PRODUTOS (
LIKE PRODUTOS );


-- CRIAR TABELA COM FK
-- FK ESTABELECE O RELACIONAMENTO ENTRE DUAS TABELAS

USE vendas_sucos; 
CREATE TABLE TABELA_DE_VENDAS
(NUMERO VARCHAR(5) NOT NULL, 
DATA_VENDA DATE NULL, 
CPF VARCHAR(11) NOT NULL, 
MATRICULA VARCHAR(5) NOT NULL, 
IMPOSTO FLOAT NULL, 
PRIMARY KEY (NUMERO)
);

ALTER TABLE TABELA_DE_VENDAS ADD CONSTRAINT FK_CLIENTES
FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF);
-- A COLUNA CPF DE VENDAS CORRESPONDE A MESMA COLUNA CPF DE CLIENTES QUE É PK
-- O banco de dados irá verificar se todos os campos que fazem referências à tabela estão especificados.

/*Determinar esse tipo de relacionamento, 
fica garantida a integridade das informações. 
Os valores presentes nas clunas definidas como chave 
estrangeira devem ter um correspondente em outra tabela,
caso contrário o bando de dados deve retornar uma mensagem de erro, 
assim as restrições de chave estrangeira identificam os relacionamentos
entre tabelas e assegura que a integridade referencial seja mantida.*/
 
ALTER TABLE TABELA_DE_VENDAS ADD CONSTRAINT FK_VENDEDORES
FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);

-- O QUE É CONSTRAINT: É UMA REGRA DA TABELA



USE VENDAS_SUCOS;

-- NUMERO E CODIGO_PRODUTO É PK POR ISSO TEM O NOT NULL
-- NULL É DEFAULT

CREATE TABLE ITENS_NOTAS
( NUMERO VARCHAR(5) NOT NULL, 
CODIGO_PRODUTO VARCHAR(5) NOT NULL,
QUANTIDADE INT,
PREÇO FLOAT,
PRIMARY KEY(NUMERO, CODIGO_PRODUTO) -- PRIMARY KEY COMPOSTA
);

ALTER TABLE ITENS_NOTAS ADD CONSTRAINT FK_NOTAS
FOREIGN KEY (NUMERO)
REFERENCES NOTAS(NUMERO); -- PK DE NOTAS

-- OU

CREATE TABLE ITENS_NOTAS
( NUMERO VARCHAR(5) NOT NULL, 
CODIGO_PRODUTO VARCHAR(5) NOT NULL,
QUANTIDADE INT,
PREÇO FLOAT,
PRIMARY KEY(NUMERO, CODIGO_PRODUTO), -- PRIMARY KEY COMPOSTA
CONSTRAINT FK_NOTAS
FOREIGN KEY (NUMERO)
REFERENCES VENDAS_SUCOS.NOTAS(NUMERO)
);

-- VER UM BANCO DE DADOS EM FORMATO LÓGICO
-- SELECIONAR O DATABASE
-- IR NO MENU DETABASE
-- CLICAR EM REVERSE ENGENEER
-- TEM COMO EXPORTAR

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- INSERIR

INSERT INTO PRODUTOS VALUES();
INSERT INTO PRODUTOS(COLUNA) VALUES();
INSERT INTO PRODUTOS SELECT; 

-- ALTERAR

UPDATE TABELA
SET COLUNA_A = X, COLUNA_B = COLUNA_B * K
WHERE COLUNA_Z = Y;


-- FUNÇÃO SUBSTRING

SELECT * FROM DATABASEA
INNER JOIN DATABASEb.TABELA B
ON A.COLUNA = SUBSTRING(B.COLUNA, 3, 3)
-- EXEMPLO SE FOR 00234 O RESULTADO SERÁ 234 COMEÇA A PARTIR DO TERCEIRO E PEGA OS PRÓXIMOS 3 NÚMEROS

UPDATE DATABASEA
INNER JOIN DATABADE.TABELA B
ON A.COLUNA = SUBSTRING(B.COLUNA, 3, 3)
SET A.FERIAS = B.FERIAS; 

/* Podemos observar que os vendedores possuem bairro 
associados a eles. Vamos aumentar em 30% o volume de 
compra dos clientes que possuem, em seus endereços 
bairros onde os vendedores possuam escritórios.*/

UPDATE CLIENTES A INNER JOIN VENDEDORES B
ON A.BAIRRO = B.BAIRRO
SET A.VOLUME_COMPRA = A.VOLUME_COMPRA * 1.30


-- DELETE REGISTROS
DELETE FROM PRODUTOS WHERE TAMANHO = '1 LITRO'
AND SUBSTRING(DESCRITOR, 1, 15) = "SABOR DOS ALPES"; 


SELECT CODIGO FROM PRODUTOS WHERE CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM SUCOS_VENDAS.TABELA_DE_PRODUTOS)

DELETE FROM PRODUTOS WHERE CODIGO NOT IN SELECT CODIGO FROM PRODUTOS WHERE CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM SUCOS_VENDAS.TABELA_DE_PRODUTOS)

-- DELETAR TUDO DESSAS TABELAS

DELETE FROM ITENS_NOTAS;
DELETE FROM NOTAS;

/* Agora, se eu crio uma transação tudo que eu fizer depois de eu 
criar a transação vai ficar em memória, não vai ser gravado no banco, 
ou seja, eu posso dar INSERTS, UPDATES, DELETES, porém depois que eu 
encerrar a transação aí sim dependendo da forma como eu encerro a transação 
eu realmente efetivo a gravação, as modificações na base de dados ou não. */


START TRANSACTION; -- CRIA UM PONTO DE ESTADO DO BANCO DE DADOS

COMMIT; -- CONFIRMO TODAS AS OPERAÇÕES ENTRE O START TRANSACTION E O COMANDO COMMIT (INSERTS, UPDATES, DELETES)

ROLLBACK; -- TUDO O QUE FOI FEITO ENTRE O START TRANSACTION E O COMANDO ROLLBACK SERÁ DESPREZADO 


-- AUTO INCREMENTO
--  É um número sequencial que será incluído dentro dessa coluna de forma automática, na medida em que eu vou dando INSERTS.
-- PODEMOS TER 1 CAMPO AUTO_INCREMENT POR TABELA
-- PODEMOS FORÇAR O VALOR DO AUTO INCREMENTO DURANTE O INSERT

USE VENDAS_SUCOS;
CREATE TABLE TAB_INDENTITY
( ID INT AUTO_INCREMENT, 
DESCRITOR VARCHAR(20), 
PRIMARY KEY (ID)
);

INSERT INTO TAB_INDENTITY (DESCRITOR) VALUES ('CLIENTE1');

SELECT * FROM TAB_INDENTITY;

INSERT INTO TAB_INDENTITY (DESCRITOR) VALUES ('CLIENTE2');

SELECT * FROM TAB_INDENTITY;

DELETE FROM TAB_INDENTITY;

INSERT INTO TAB_INDENTITY (ID, DESCRITOR) VALUES (100, 'CLIENTE7');
SELECT * FROM TAB_INDENTITY;

INSERT INTO TAB_INDENTITY (DESCRITOR) VALUES ('CLIENTE8');
SELECT * FROM TAB_INDENTITY;


-- CURRETN ITMESTAMP

CREATE TABLE TAB_PADRAO
(ID INT AUTO_INCREMENT, 
DESCRITOR VARCHAR(20), 
ENDERECO VARCHAR(100) NULL, 
CIDADE VARCHAR(50) DEFAULT 'RIO DE JANEIRO',
DATA_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
PRIMARY KEY(ID)
);

INSERT INTO TAB_PADRAO (DESCRITOR, ENDERECO, CIDADE, DATA_CRIACAO)
VALUES ('CLIENTE X', 'RUA PROJETADA A', 'SÃO PAULO', '2019-01-01');

SELECT * FROM TAB_PADRAO;

INSERT INTO TAB_PADRAO (DESCRITOR)
VALUES ('CLIENTE X');

-- TRIGGER
-- É uma regra que é disparada no momento em que uma tabela sofre 
-- uma modificação nos seus dados, 
-- ou seja, uma inclusão, alteração ou exclusão.

-- O BEFORE INSERT é responsável por disparar a 
-- TRIGGER antes que um evento de inserção ocorra na tabela.
DELIMITER//
CREATE TRIGGER nome_do_trigger
    BEFORE INSERT
    ON nome_da_tabela FOR EACH ROW
BEGIN
-- codigo_a_ser_executado
END//

DELIMITER //
CREATE TRIGGER CALCULA_FATURAMENTO_APOS_INSERT
    AFTER INSERT
    ON ITENS_NOTAS FOR EACH ROW
BEGIN
	SELECT SUM(FATURAMENTO) FROM INTES_NOTAS;
END //

