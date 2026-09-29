-- populate1.sql
-- Base de Dados - Agência Imobiliária Database

PRAGMA foreign_keys = ON;

-- PESSOAS 
INSERT INTO Pessoa (nif, nomeCompleto, contacto) VALUES 
('123456789', 'João Silva', '912345678'),
('234567890', 'Maria Santos', '923456789'),
('345678901', 'António Costa', '934567890'),
('456789012', 'Ana Ferreira', '945678901'),
('567890123', 'Pedro Oliveira', '956789012'),
('678901234', 'Sofia Rodrigues', '967890123'),
('789012345', 'Carlos Pereira', '978901234'),
('890123456', 'Beatriz Almeida', '989012345');

-- AGENCIAS IMOBILIARIAS 
INSERT INTO AgenciaImobiliaria (nif, nome, contacto, morada) VALUES 
('111111111', 'Imobiliária Central', '210000001', 'Rua Central 100, Lisboa'),
('222222222', 'Casa Nova Imobiliária', '210000002', 'Av. da Liberdade 50, Porto'),
('333333333', 'Lar Doce Lar', '210000003', 'Praça do Comércio 25, Coimbra');

-- PROPRIETARIOS 
INSERT INTO Proprietario (nif, intencaoEmArrendarOuVender) VALUES 
('123456789', 'Vender'),
('234567890', 'Arrendar'),
('345678901', 'Vender');

-- AGENTES 
INSERT INTO Agente (nif, numColaborador, nifAgencia) VALUES 
('456789012', 'AG001', '111111111'),
('567890123', 'AG002', '111111111'),
('678901234', 'AG003', '222222222');

-- CLIENTES (Clients)
INSERT INTO Cliente (nif, orcamento, interesseEmComprarOuArrendar, tipoImovelDesejado) VALUES 
('789012345', 250000.00, 'Comprar', 'Apartamento'),
('890123456', 800.00, 'Arrendar', 'T1');

-- LOCAIS 
INSERT INTO Local (nomeLocal, cidade) VALUES 
('Baixa', 'Lisboa'),
('Chiado', 'Lisboa'),
('Ribeira', 'Porto'),
('Foz', 'Porto'),
('Alta', 'Coimbra');

-- CLIENTE-LOCAL 
INSERT INTO ClienteLocal (nifCliente, nomeLocal, cidade) VALUES 
('789012345', 'Baixa', 'Lisboa'),
('789012345', 'Chiado', 'Lisboa'),
('890123456', 'Ribeira', 'Porto');

-- IMOVEIS 
INSERT INTO Imovel (morada, tipo, area, numeroDeDivisoes, caracteristicasRelevantes, precoArrendamentoOuVenda, nifProprietario, nifAgente, nifAgencia, nomeLocal, cidade) VALUES 
('Rua Augusta 10, Lisboa', 'Apartamento', 85.5, 3, 'Vista para o rio, varanda', 280000.00, '123456789', '456789012', '111111111', 'Baixa', 'Lisboa'),
('Rua das Flores 25, Porto', 'T1', 45.0, 2, 'Renovado, cozinha equipada', 650.00, '234567890', '678901234', '222222222', 'Ribeira', 'Porto'),
('Av. da Liberdade 100, Lisboa', 'T3', 120.0, 4, 'Luxo, garagem', 450000.00, '345678901', '567890123', '111111111', 'Chiado', 'Lisboa');

-- VISITAS 
INSERT INTO Visita (nifCliente, morada, data, hora, observacoes, nifAgente) VALUES 
('789012345', 'Rua Augusta 10, Lisboa', '2024-03-15', '10:00', 'Cliente interessado', '456789012'),
('789012345', 'Av. da Liberdade 100, Lisboa', '2024-03-16', '15:30', 'Achou caro', '567890123'),
('890123456', 'Rua das Flores 25, Porto', '2024-03-17', '11:00', 'Gostou muito', '678901234');

-- TRANSACOES 
INSERT INTO Transacao (morada, nifCliente, data, tipo, comissaoAgencia, valor, nifAgencia) VALUES 
('Rua das Flores 25, Porto', '890123456', '2024-03-20', 'Arrendamento', 650.00, 650.00, '222222222');