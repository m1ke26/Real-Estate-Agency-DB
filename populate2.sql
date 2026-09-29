-- populate2.sql
-- Base de Dados - Agência Imobiliária Database
-- Refinado com IA Generativa (Claude)

-- CONFIGURAÇÕES PRAGMA PARA MELHOR INTEGRIDADE
PRAGMA foreign_keys = ON;

-- Limpar dados existentes (para recarregamento limpo)
DELETE FROM Transacao;
DELETE FROM Visita;
DELETE FROM ClienteLocal;
DELETE FROM Imovel;
DELETE FROM Local;
DELETE FROM Cliente;
DELETE FROM Agente;
DELETE FROM Proprietario;
DELETE FROM AgenciaImobiliaria;
DELETE FROM Pessoa;

-- PESSOAS 
INSERT INTO Pessoa (nif, nomeCompleto, contacto) VALUES 
-- Proprietário
('123456789', 'João Manuel Silva', '912345678'),
('234567890', 'Maria Helena Santos', '923456789'),
('345678901', 'António José Costa', '934567890'),
('111222333', 'Rui Miguel Fernandes', '911222333'),
-- Agentes
('456789012', 'Ana Maria Ferreira', '945678901'),
('567890123', 'Pedro Nuno Oliveira', '956789012'),
('678901234', 'Sofia Isabel Rodrigues', '967890123'),
('444555666', 'Miguel Ângelo Sousa', '944555666'),
-- Clientes
('789012345', 'Carlos Alberto Pereira', '978901234'),
('890123456', 'Beatriz Luísa Almeida', '989012345'),
('999888777', 'Fernando Jorge Martins', '999888777'),
('777666555', 'Catarina Rosa Lopes', '977666555'),
-- Pessoa que é proprietário e cliente (herança overlapping)
('555444333', 'Ricardo Manuel Dias', '955444333');

-- AGENCIAS IMOBILIARIAS
INSERT INTO AgenciaImobiliaria (nif, nome, contacto, morada) VALUES 
('100000001', 'Imobiliária Central', '210000001', 'Rua Central 100, 1100-001 Lisboa'),
('200000002', 'Casa Nova Imobiliária', '220000002', 'Av. da Liberdade 50, 4000-001 Porto'),
('300000003', 'Lar Doce Lar', '230000003', 'Praça do Comércio 25, 3000-001 Coimbra'),
('400000004', 'Imóveis do Sul', '240000004', 'Rua Principal 1, 8000-001 Faro');

-- PROPRIETARIOS 
INSERT INTO Proprietario (nif, intencaoEmArrendarOuVender) VALUES 
('123456789', 'Vender'),
('234567890', 'Arrendar'),
('345678901', 'Vender'),
('111222333', 'Arrendar'),
('555444333', 'Vender');  

-- AGENTES 
INSERT INTO Agente (nif, numColaborador, nifAgencia) VALUES 
('456789012', 'AG-001', '100000001'),
('567890123', 'AG-002', '100000001'),
('678901234', 'AG-003', '200000002'),
('444555666', 'AG-004', '300000003');

-- CLIENTES
INSERT INTO Cliente (nif, orcamento, interesseEmComprarOuArrendar, tipoImovelDesejado) VALUES 
('789012345', 300000.00, 'Comprar', 'Apartamento T2/T3'),
('890123456', 900.00, 'Arrendar', 'T1'),
('999888777', 500000.00, 'Comprar', 'Moradia'),
('777666555', 1200.00, 'Arrendar', 'T2'),
('555444333', 180000.00, 'Comprar', 'Apartamento');  

-- LOCAIS
INSERT INTO Local (nomeLocal, cidade) VALUES 
-- Lisboa
('Baixa', 'Lisboa'),
('Chiado', 'Lisboa'),
('Alfama', 'Lisboa'),
('Belém', 'Lisboa'),
('Parque das Nações', 'Lisboa'),
-- Porto
('Ribeira', 'Porto'),
('Foz do Douro', 'Porto'),
('Boavista', 'Porto'),
('Cedofeita', 'Porto'),
-- Coimbra
('Alta', 'Coimbra'),
('Baixa', 'Coimbra'),
-- Faro
('Centro', 'Faro'),
('Praia', 'Faro');

-- CLIENTE-LOCAL
INSERT INTO ClienteLocal (nifCliente, nomeLocal, cidade) VALUES 
-- Carlos quer comprar em Lisboa
('789012345', 'Baixa', 'Lisboa'),
('789012345', 'Chiado', 'Lisboa'),
('789012345', 'Parque das Nações', 'Lisboa'),
-- Beatriz quer arrendar no Porto
('890123456', 'Ribeira', 'Porto'),
('890123456', 'Cedofeita', 'Porto'),
-- Fernando quer uma moradia
('999888777', 'Foz do Douro', 'Porto'),
('999888777', 'Belém', 'Lisboa'),
-- Catarina quer arrendar em Coimbra
('777666555', 'Alta', 'Coimbra'),
('777666555', 'Baixa', 'Coimbra'),
-- Ricardo quer comprar em Faro
('555444333', 'Centro', 'Faro'),
('555444333', 'Praia', 'Faro');

-- IMOVEIS 
INSERT INTO Imovel (morada, tipo, area, numeroDeDivisoes, caracteristicasRelevantes, precoArrendamentoOuVenda, nifProprietario, nifAgente, nifAgencia, nomeLocal, cidade) VALUES 
-- Á venda
('Rua Augusta 10, 2º Dto, Lisboa', 'Apartamento T2', 85.5, 3, 'Vista rio Tejo, varanda, elevador', 285000.00, '123456789', '456789012', '100000001', 'Baixa', 'Lisboa'),
('Av. da Liberdade 100, 5º Esq, Lisboa', 'Apartamento T3', 120.0, 4, 'Luxo, garagem, porteiro', 520000.00, '345678901', '567890123', '100000001', 'Chiado', 'Lisboa'),
('Rua do Sol 15, Faro', 'Moradia V3', 180.0, 5, 'Piscina, jardim, garagem 2 carros', 380000.00, '555444333', '444555666', '400000004', 'Praia', 'Faro'),
-- A arrendar
('Rua das Flores 25, 1º, Porto', 'T1', 45.0, 2, 'Renovado 2023, cozinha equipada', 750.00, '234567890', '678901234', '200000002', 'Ribeira', 'Porto'),
('Rua Ferreira Borges 8, Porto', 'T2', 70.0, 3, 'Centro histórico, mobilado', 950.00, '234567890', '678901234', '200000002', 'Cedofeita', 'Porto'),
('Rua Larga 50, Coimbra', 'T1', 40.0, 2, 'Junto à universidade, remodelado', 550.00, '111222333', '444555666', '300000003', 'Alta', 'Coimbra');

-- VISITAS
INSERT INTO Visita (nifCliente, morada, data, hora, observacoes, nifAgente) VALUES 
-- Carlos a visitar imóveis para comprar
('789012345', 'Rua Augusta 10, 2º Dto, Lisboa', '2024-03-10', '10:00', 'Gostou da localização e vista. Pediu mais informações sobre condomínio.', '456789012'),
('789012345', 'Rua Augusta 10, 2º Dto, Lisboa', '2024-03-15', '11:30', 'Segunda visita com esposa. Muito interessados.', '456789012'),
('789012345', 'Av. da Liberdade 100, 5º Esq, Lisboa', '2024-03-12', '15:00', 'Achou o preço elevado para o orçamento.', '567890123'),
-- Beatriz a visitar arrendamentos
('890123456', 'Rua das Flores 25, 1º, Porto', '2024-03-14', '09:30', 'Adorou o apartamento. Quer avançar com contrato.', '678901234'),
('890123456', 'Rua Ferreira Borges 8, Porto', '2024-03-14', '11:00', 'Bom apartamento mas prefere o T1.', '678901234'),
-- Catarina a visitar em Coimbra
('777666555', 'Rua Larga 50, Coimbra', '2024-03-18', '14:00', 'Ideal para estudante. Vai confirmar com os pais.', '444555666'),
-- Fernando a visitar moradias
('999888777', 'Rua do Sol 15, Faro', '2024-03-20', '10:30', 'Excelente para férias. A considerar.', '444555666');

-- TRANSACOES
INSERT INTO Transacao (morada, nifCliente, data, tipo, comissaoAgencia, valor, nifAgencia) VALUES 
-- Arrendamento concluído
('Rua das Flores 25, 1º, Porto', '890123456', '2024-03-25', 'Arrendamento', 750.00, 750.00, '200000002'),
-- Outro arrendamento
('Rua Larga 50, Coimbra', '777666555', '2024-03-28', 'Arrendamento', 550.00, 550.00, '300000003'),
-- Venda concluída (Carlos comprou o apartamento)
('Rua Augusta 10, 2º Dto, Lisboa', '789012345', '2024-04-05', 'Venda', 14250.00, 285000.00, '100000001');