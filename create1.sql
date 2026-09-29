-- create1.sql
-- Base de Dados - Agência Imobiliária Database

-- Apagar tabelas existentes
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


-- TABELAS BASE

-- Pessoa - Entidade base para herança
CREATE TABLE Pessoa (
    nif TEXT PRIMARY KEY,
    nomeCompleto TEXT NOT NULL,
    contacto TEXT NOT NULL
);

-- AgenciaImobiliaria
-- Candidate key: (nif)
CREATE TABLE AgenciaImobiliaria (
    nif TEXT PRIMARY KEY,
    nome TEXT NOT NULL,
    contacto TEXT NOT NULL,
    morada TEXT NOT NULL
);


-- ESPECIALIZAÇÕES DE PESSOA (overlapping, complete)

-- Proprietario
-- Constraint: intencaoEmArrendarOuVender IN ('Arrendar', 'Vender')
CREATE TABLE Proprietario (
    nif TEXT PRIMARY KEY,
    intencaoEmArrendarOuVender TEXT NOT NULL,
    FOREIGN KEY (nif) REFERENCES Pessoa(nif),
    CHECK (intencaoEmArrendarOuVender IN ('Arrendar', 'Vender'))
);

-- Agente 
-- Candidate key: (numColaborador)
CREATE TABLE Agente (
    nif TEXT PRIMARY KEY,
    numColaborador TEXT NOT NULL UNIQUE,
    nifAgencia TEXT NOT NULL,
    FOREIGN KEY (nif) REFERENCES Pessoa(nif),
    FOREIGN KEY (nifAgencia) REFERENCES AgenciaImobiliaria(nif)
);

-- Cliente 
-- Constraints: orcamento > 0, interesseEmComprarOuArrendar IN ('Comprar', 'Arrendar')
CREATE TABLE Cliente (
    nif TEXT PRIMARY KEY,
    orcamento REAL NOT NULL,
    interesseEmComprarOuArrendar TEXT NOT NULL,
    tipoImovelDesejado TEXT,
    FOREIGN KEY (nif) REFERENCES Pessoa(nif),
    CHECK (orcamento > 0),
    CHECK (interesseEmComprarOuArrendar IN ('Comprar', 'Arrendar'))
);


-- LOCALIZACAO

-- Local (Location)
-- Candidate key: (localDesejado, cidade) - composite primary key
CREATE TABLE Local (
    nomeLocal TEXT NOT NULL,
    cidade TEXT NOT NULL,
    PRIMARY KEY (nomeLocal, cidade)
);

-- ClienteLocal (Many-to-many relationship: Cliente interested in Local)
CREATE TABLE ClienteLocal (
    nifCliente TEXT NOT NULL,
    nomeLocal TEXT NOT NULL,
    cidade TEXT NOT NULL,
    PRIMARY KEY (nifCliente, nomeLocal, cidade),
    FOREIGN KEY (nifCliente) REFERENCES Cliente(nif),
    FOREIGN KEY (nomeLocal, cidade) REFERENCES Local(nomeLocal, cidade)
);


-- PROPRIEDADE

-- Imovel 
-- Candidate key: (morada, Local)
-- Constraint: precoArrendamentoOuVenda > 0
CREATE TABLE Imovel (
    morada TEXT PRIMARY KEY,
    tipo TEXT NOT NULL,
    area REAL NOT NULL,
    numeroDeDivisoes INTEGER NOT NULL,
    caracteristicasRelevantes TEXT,
    precoArrendamentoOuVenda REAL NOT NULL,
    nifProprietario TEXT NOT NULL,
    nifAgente TEXT NOT NULL,
    nifAgencia TEXT NOT NULL,
    nomeLocal TEXT NOT NULL,
    cidade TEXT NOT NULL,
    FOREIGN KEY (nifProprietario) REFERENCES Proprietario(nif),
    FOREIGN KEY (nifAgente) REFERENCES Agente(nif),
    FOREIGN KEY (nifAgencia) REFERENCES AgenciaImobiliaria(nif),
    FOREIGN KEY (nomeLocal, cidade) REFERENCES Local(nomeLocal, cidade),
    CHECK (precoArrendamentoOuVenda > 0)
);


-- VISITA E TRANSACAO

-- Visita 
CREATE TABLE Visita (
    nifCliente TEXT NOT NULL,
    morada TEXT NOT NULL,
    data TEXT NOT NULL,
    hora TEXT NOT NULL,
    observacoes TEXT,
    nifAgente TEXT NOT NULL,
    PRIMARY KEY (nifCliente, morada, data, hora),
    FOREIGN KEY (nifCliente) REFERENCES Cliente(nif),
    FOREIGN KEY (morada) REFERENCES Imovel(morada),
    FOREIGN KEY (nifAgente) REFERENCES Agente(nif)
);

-- Transacao 
-- Candidate key: (Imovel, data)
-- Constraints: tipo IN ('Venda', 'Arrendamento'), valor > 0, comissaoAgencia <= valor
CREATE TABLE Transacao (
    morada TEXT NOT NULL,
    nifCliente TEXT NOT NULL,
    data TEXT NOT NULL,
    tipo TEXT NOT NULL,
    comissaoAgencia REAL NOT NULL,
    valor REAL NOT NULL,
    nifAgencia TEXT NOT NULL,
    PRIMARY KEY (morada, nifCliente, data),
    FOREIGN KEY (morada) REFERENCES Imovel(morada),
    FOREIGN KEY (nifCliente) REFERENCES Cliente(nif),
    FOREIGN KEY (nifAgencia) REFERENCES AgenciaImobiliaria(nif),
    CHECK (tipo IN ('Venda', 'Arrendamento')),
    CHECK (valor > 0),
    CHECK (comissaoAgencia <= valor),
    CHECK (comissaoAgencia >= 0)
);