/*
Instruções para criar o banco de dados NFSe_DB e suas tabelas
=====================================================
Siga estas etapas:
1. Execute cada bloco de código separadamente (selecione só o bloco e pressione F5)
2. Aguarde a confirmação antes de executar o próximo bloco
3. Siga a ordem dos blocos

Autor: Sistema NFS-e
Data: 2025-03-21
*/

-- ETAPA 1: Criar o banco de dados
-- ===============================
-- Selecione apenas este bloco e execute (F5)

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'NFSe_DB')
BEGIN
    CREATE DATABASE NFSe_DB;
    PRINT 'Banco de dados NFSe_DB criado com sucesso!';
END
ELSE
BEGIN
    PRINT 'O banco de dados NFSe_DB já existe.';
END
GO

-- ETAPA 2: Usar o banco de dados
-- ==============================
-- Selecione apenas este bloco e execute (F5)

USE NFSe_DB;
GO

-- ETAPA 3: Criar tabela RPS
-- =========================
-- Selecione apenas este bloco e execute (F5)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'RPS')
BEGIN
    CREATE TABLE RPS (
        id_rps INT IDENTITY(1,1) PRIMARY KEY,
        numero_rps VARCHAR(15) NOT NULL,
        serie_rps VARCHAR(5) NOT NULL,
        tipo_rps INT DEFAULT 1,
        data_emissao DATE NOT NULL,
        competencia DATE NOT NULL,
        
        -- Dados do prestador
        cnpj_prestador VARCHAR(14) NOT NULL,
        inscricao_municipal_prestador VARCHAR(15),
        razao_social_prestador VARCHAR(150) NOT NULL,
        nome_fantasia_prestador VARCHAR(60),
        
        -- Dados do tomador
        cnpj_tomador VARCHAR(14),
        cpf_tomador VARCHAR(11),
        inscricao_municipal_tomador VARCHAR(15),
        razao_social_tomador VARCHAR(150) NOT NULL,
        endereco_tomador VARCHAR(125),
        numero_endereco_tomador VARCHAR(10),
        complemento_tomador VARCHAR(60),
        bairro_tomador VARCHAR(60),
        cidade_tomador VARCHAR(7), -- Código IBGE
        uf_tomador CHAR(2),
        cep_tomador VARCHAR(8),
        email_tomador VARCHAR(80),
        
        -- Dados do serviço
        valor_servico DECIMAL(15,2) NOT NULL,
        valor_deducoes DECIMAL(15,2) DEFAULT 0,
        valor_pis DECIMAL(15,2) DEFAULT 0,
        valor_cofins DECIMAL(15,2) DEFAULT 0,
        valor_inss DECIMAL(15,2) DEFAULT 0,
        valor_ir DECIMAL(15,2) DEFAULT 0,
        valor_csll DECIMAL(15,2) DEFAULT 0,
        valor_outras_retencoes DECIMAL(15,2) DEFAULT 0,
        valor_iss DECIMAL(15,2) DEFAULT 0,
        aliquota_iss DECIMAL(6,4) DEFAULT 0,
        descricao_servico VARCHAR(2000),
        codigo_servico VARCHAR(5),
        codigo_municipio_prestacao VARCHAR(7),
        
        -- Status e controle
        status_rps VARCHAR(20) DEFAULT 'PENDENTE', -- PENDENTE, TRANSMITIDA, ERRO
        numero_nfse VARCHAR(15),
        codigo_verificacao VARCHAR(20),
        data_transmissao DATETIME,
        protocolo_envio VARCHAR(50),
        mensagem_erro VARCHAR(500),
        data_registro DATETIME DEFAULT GETDATE()
    );
    PRINT 'Tabela RPS criada com sucesso!';
END
ELSE
BEGIN
    PRINT 'A tabela RPS já existe.';
END
GO

-- ETAPA 4: Criar tabela LOG_TRANSMISSAO
-- =====================================
-- Selecione apenas este bloco e execute (F5)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LOG_TRANSMISSAO')
BEGIN
    CREATE TABLE LOG_TRANSMISSAO (
        id_log INT IDENTITY(1,1) PRIMARY KEY,
        id_rps INT,
        operacao VARCHAR(50) NOT NULL, -- ENVIO, CONSULTA_SITUACAO, CONSULTA_LOTE
        data_operacao DATETIME DEFAULT GETDATE(),
        sucesso BIT NOT NULL,
        mensagem VARCHAR(500),
        FOREIGN KEY (id_rps) REFERENCES RPS (id_rps)
    );
    PRINT 'Tabela LOG_TRANSMISSAO criada com sucesso!';
END
ELSE
BEGIN
    PRINT 'A tabela LOG_TRANSMISSAO já existe.';
END
GO

-- ETAPA 5: Criar a view para RPS pendentes
-- ========================================
-- Selecione apenas este bloco e execute (F5)

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_rps_pendentes')
BEGIN
    DROP VIEW vw_rps_pendentes;
    PRINT 'View vw_rps_pendentes excluída para recriação.';
END
GO

CREATE VIEW vw_rps_pendentes AS
SELECT 
    id_rps, numero_rps, serie_rps, data_emissao, 
    razao_social_tomador, valor_servico, descricao_servico, status_rps
FROM 
    RPS
WHERE 
    status_rps = 'PENDENTE';
GO
PRINT 'View vw_rps_pendentes criada com sucesso!';
GO

-- ETAPA 6: Criar a view para RPS transmitidas
-- ==========================================
-- Selecione apenas este bloco e execute (F5)

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_rps_transmitidas')
BEGIN
    DROP VIEW vw_rps_transmitidas;
    PRINT 'View vw_rps_transmitidas excluída para recriação.';
END
GO

CREATE VIEW vw_rps_transmitidas AS
SELECT 
    id_rps, numero_rps, serie_rps, data_emissao, 
    razao_social_tomador, valor_servico, numero_nfse, data_transmissao, 
    protocolo_envio, status_rps
FROM 
    RPS
WHERE 
    status_rps = 'TRANSMITIDA';
GO
PRINT 'View vw_rps_transmitidas criada com sucesso!';
GO

-- ETAPA 7: Inserir um registro de teste
-- ====================================
-- Selecione apenas este bloco e execute (F5)

INSERT INTO RPS (
    numero_rps, serie_rps, tipo_rps, data_emissao, competencia,
    cnpj_prestador, razao_social_prestador,
    cnpj_tomador, razao_social_tomador,
    valor_servico, descricao_servico, status_rps
)
VALUES (
    '12345', '1', 1, GETDATE(), GETDATE(),
    '12345678901234', 'EMPRESA TESTE LTDA',
    '98765432101234', 'CLIENTE TESTE LTDA',
    100.00, 'Serviço de teste para homologação do sistema', 'PENDENTE'
);
PRINT 'Registro de teste inserido com sucesso!';
GO

-- ETAPA 8: Verificar se tudo foi criado corretamente
-- =================================================
-- Selecione apenas este bloco e execute (F5)

SELECT 'Tabelas criadas:' AS Informacao;
SELECT name AS 'Tabelas' FROM sys.tables;

SELECT 'Views criadas:' AS Informacao;
SELECT name AS 'Views' FROM sys.views 
WHERE name LIKE 'vw_%';

SELECT 'Dados de teste:' AS Informacao;
SELECT * FROM RPS;
GO

PRINT 'Configuração do banco de dados concluída com sucesso!';
GO