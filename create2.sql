-- create2.sql
-- Base de Dados - Agência Imobiliária Database
-- Refinado com IA Generativa (Claude)

-- CONFIGURAÇÕES PRAGMA PARA MELHOR INTEGRIDADE
PRAGMA foreign_keys = OFF; -- Desativar durante recriação de tabelas

-- Apagar tabelas existentes (ordem inversa das dependências)
DROP TABLE IF EXISTS Transacao;
DROP TABLE IF EXISTS Visita;
DROP TABLE IF EXISTS ClienteLocal;
DROP TABLE IF EXISTS Imovel;
DROP TABLE IF EXISTS Local;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Agente;
DROP TABLE IF EXISTS Proprietario;
DROP TABLE IF EXISTS AgenciaImobiliaria;
DROP TABLE IF EXISTS Pessoa;

-- Reativar chaves estrangeiras após drops
PRAGMA foreign_keys = ON;


-- TABELAS BASE

-- Pessoa (Person) -  Entidade base para hierarquia de herança
-- Nota: O SQLite não suporta CHECK no comprimento, mas adicionamos NOT NULL para campos obrigatórios
CREATE TABLE Pessoa (
    nif TEXT PRIMARY KEY
        CHECK (length(nif) = 9),  -- NIF português tem 9 dígitos
    nomeCompleto TEXT NOT NULL
        CHECK (length(nomeCompleto) > 0),
    contacto TEXT NOT NULL
        CHECK (length(contacto) > 0)
);

-- AgenciaImobiliaria 
CREATE TABLE AgenciaImobiliaria (
    nif TEXT PRIMARY KEY
        CHECK (length(nif) = 9),
    nome TEXT NOT NULL
        CHECK (length(nome) > 0),
    contacto TEXT NOT NULL,
    morada TEXT NOT NULL
        CHECK (length(morada) > 0)
);

-- Proprietario 
CREATE TABLE Proprietario (
    nif TEXT PRIMARY KEY
        REFERENCES Pessoa(nif)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    intencaoEmArrendarOuVender TEXT NOT NULL
        CHECK (intencaoEmArrendarOuVender IN ('Arrendar', 'Vender'))
);

-- Agente 
CREATE TABLE Agente (
    nif TEXT PRIMARY KEY
        REFERENCES Pessoa(nif)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    numColaborador TEXT NOT NULL UNIQUE
        CHECK (length(numColaborador) > 0),
    nifAgencia TEXT NOT NULL
        REFERENCES AgenciaImobiliaria(nif)
        ON DELETE RESTRICT  -- Não é possível excluir agência com agentes ativos
        ON UPDATE CASCADE
);

-- Cliente 
CREATE TABLE Cliente (
    nif TEXT PRIMARY KEY
        REFERENCES Pessoa(nif)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    orcamento REAL NOT NULL
        CHECK (orcamento > 0),
    interesseEmComprarOuArrendar TEXT NOT NULL
        CHECK (interesseEmComprarOuArrendar IN ('Comprar', 'Arrendar')),
    tipoImovelDesejado TEXT -- Pode ser NULL se o cliente for flexível
);

-- LOCALIZACAO

-- Local
CREATE TABLE Local (
    nomeLocal TEXT NOT NULL
        CHECK (length(nomeLocal) > 0),
    cidade TEXT NOT NULL
        CHECK (length(cidade) > 0),
    PRIMARY KEY (nomeLocal, cidade)
);

-- ClienteLocal 
CREATE TABLE ClienteLocal (
    nifCliente TEXT NOT NULL
        REFERENCES Cliente(nif)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    nomeLocal TEXT NOT NULL,
    cidade TEXT NOT NULL,
    PRIMARY KEY (nifCliente, nomeLocal, cidade),
    FOREIGN KEY (nomeLocal, cidade) 
        REFERENCES Local(nomeLocal, cidade)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- PROPRIEDADE

-- Imovel
CREATE TABLE Imovel (
    morada TEXT PRIMARY KEY
        CHECK (length(morada) > 0),
    tipo TEXT NOT NULL
        CHECK (length(tipo) > 0),
    area REAL NOT NULL
        CHECK (area > 0),
    numeroDeDivisoes INTEGER NOT NULL
        CHECK (numeroDeDivisoes >= 0),
    caracteristicasRelevantes TEXT,  -- Descrição opcional
    precoArrendamentoOuVenda REAL NOT NULL
        CHECK (precoArrendamentoOuVenda > 0),
    nifProprietario TEXT NOT NULL
        REFERENCES Proprietario(nif)
        ON DELETE RESTRICT  -- Não pode apagar proprietário com imóveis
        ON UPDATE CASCADE,
    nifAgente TEXT NOT NULL
        REFERENCES Agente(nif)
        ON DELETE RESTRICT  -- Não pode apagar agente que gere imóveis
        ON UPDATE CASCADE,
    nifAgencia TEXT NOT NULL
        REFERENCES AgenciaImobiliaria(nif)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    nomeLocal TEXT NOT NULL,
    cidade TEXT NOT NULL,
    FOREIGN KEY (nomeLocal, cidade) 
        REFERENCES Local(nomeLocal, cidade)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Índice para pesquisas comuns por localização de imóvel
CREATE INDEX idx_imovel_local ON Imovel(nomeLocal, cidade);
CREATE INDEX idx_imovel_agente ON Imovel(nifAgente);


-- VISITAS

-- Visitas
CREATE TABLE Visita (
    nifCliente TEXT NOT NULL
        REFERENCES Cliente(nif)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    morada TEXT NOT NULL
        REFERENCES Imovel(morada)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    data TEXT NOT NULL
        CHECK (data GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),  -- Formato AAAA-MM-DD
    hora TEXT NOT NULL
        CHECK (hora GLOB '[0-2][0-9]:[0-5][0-9]'),  -- Formato HH:MM
    observacoes TEXT,
    nifAgente TEXT NOT NULL
        REFERENCES Agente(nif)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    PRIMARY KEY (nifCliente, morada, data, hora)
);

-- Índice para pesquisar visitas por data
CREATE INDEX idx_visita_data ON Visita(data);


-- TRANSACAO

-- Transacao (Transacao de renda ou compra)
CREATE TABLE Transacao (
    morada TEXT NOT NULL
        REFERENCES Imovel(morada)
        ON DELETE RESTRICT  -- Não pode apagar imóvel com transações
        ON UPDATE CASCADE,
    nifCliente TEXT NOT NULL
        REFERENCES Cliente(nif)
        ON DELETE RESTRICT  -- Não pode apagar cliente com transações
        ON UPDATE CASCADE,
    data TEXT NOT NULL
        CHECK (data GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
    tipo TEXT NOT NULL
        CHECK (tipo IN ('Venda', 'Arrendamento')),
    comissaoAgencia REAL NOT NULL
        CHECK (comissaoAgencia >= 0),
    valor REAL NOT NULL
        CHECK (valor > 0),
    nifAgencia TEXT NOT NULL
        REFERENCES AgenciaImobiliaria(nif)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    PRIMARY KEY (morada, nifCliente, data),
    -- Regra de negócio: comissão não pode exceder valor da transação
    CHECK (comissaoAgencia <= valor)
);

-- Índice para consultas de relatórios
CREATE INDEX idx_transacao_data ON Transacao(data);
CREATE INDEX idx_transacao_agencia ON Transacao(nifAgencia);
