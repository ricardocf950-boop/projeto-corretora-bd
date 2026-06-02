Inserts

INSERT INTO corretora.categoria_ativo (nome) VALUES
  ('Renda Variável'),
  ('Renda Fixa'),
  ('Fundos Imobiliários'),
  ('Criptomoedas'),
  ('ETF');
 

INSERT INTO corretora.ativo (codigo, nome, tipo, valor_atual, id_categoria_fk) VALUES
  ('PETR4',  'Petrobras PN',              'acao',     38.52,      1),
  ('VALE3',  'Vale ON',                   'acao',     62.10,      1),
  ('MXRF11', 'Maxi Renda FII',            'fii',      10.45,      3),
  ('CDB001', 'CDB Banco XP 120% CDI',     'cdb',      1000.00,    2),
  ('LCI001', 'LCI Itaú 95% CDI',          'lci',      1000.00,    2),
  ('BTC',    'Bitcoin',                   'cripto',   312540.00,  4),
  ('ETH',    'Ethereum',                  'cripto',   15820.00,   4),
  ('BOVA11', 'iShares Ibovespa ETF',      'acao',     112.30,     5);
 

INSERT INTO corretora.historico_preco (data, preco_abertura, preco_fechamento, codigo_ativo_fk) VALUES
  ('2025-05-01', 37.80, 38.10, 'PETR4'),
  ('2025-05-02', 38.10, 38.52, 'PETR4'),
  ('2025-05-01', 61.00, 62.00, 'VALE3'),
  ('2025-05-02', 62.00, 62.10, 'VALE3'),
  ('2025-05-01', 10.40, 10.42, 'MXRF11'),
  ('2025-05-02', 10.42, 10.45, 'MXRF11'),
  ('2025-05-01', 308000.00, 311000.00, 'BTC'),
  ('2025-05-02', 311000.00, 312540.00, 'BTC'),
  ('2025-05-01', 111.50, 112.00, 'BOVA11'),
  ('2025-05-02', 112.00, 112.30, 'BOVA11');
 

INSERT INTO corretora.taxa (descricao, percentual, tipo, id_categoria_fk) VALUES
  ('Corretagem Renda Variável',0.25, 'corretagem',1),
  ('Corretagem FII',0.25, 'corretagem',3),
  ('Administração Renda Fixa',0.50, 'administracao', 2),
  ('Custódia Cripto',0.10, 'custodia',4),
  ('Corretagem ETF',0.10, 'corretagem',5);
 

INSERT INTO corretora.cliente (cpf, nome, data_nasc, perfil_risco, email) VALUES
  ('12345678901', 'Ana Lima',        '1990-03-15', 'arrojado',     'ana.lima@email.com'),
  ('23456789012', 'Bruno Souza',     '1985-07-22', 'moderado',     'bruno.souza@email.com'),
  ('34567890123', 'Carla Mendes',    '1995-11-08', 'conservador',  'carla.mendes@email.com'),
  ('45678901234', 'Diego Ferreira',  '1978-01-30', 'arrojado',     'diego.f@email.com'),
  ('56789012345', 'Eva Rodrigues',   '2000-06-18', 'moderado',     'eva.rod@email.com'),
  ('67890123456', 'Felipe Castro',   '1992-09-25', 'conservador',  'felipe.c@email.com');
 

INSERT INTO corretora.telefone_cliente (cpf_fk, telefone) VALUES
  ('12345678901', '82999990001'),
  ('12345678901', '82988880001'),  -- Ana com 2 telefones
  ('23456789012', '82999990002'),
  ('34567890123', '82999990003'),
  ('45678901234', '82999990004'),
  ('56789012345', '82999990005'),
  ('67890123456', '82999990006'),
  ('67890123456', '82977770006'); -- Felipe com 2 telefones
 

INSERT INTO corretora.endereco (cep, rua, bairro, cidade, estado, cpf_fk) VALUES
  ('57300000', 'Rua das Flores, 10',    'Centro',       'Arapiraca',  'AL', '12345678901'),
  ('57301000', 'Av. Paulista, 200',     'Bela Vista',   'São Paulo',  'SP', '23456789012'),
  ('57302000', 'Rua Sete, 45',          'Jardim',       'Maceió',     'AL', '34567890123'),
  ('57303000', 'Rua Nova, 78',          'Farol',        'Maceió',     'AL', '45678901234'),
  ('57304000', 'Av. Brasil, 320',       'Centro',       'Recife',     'PE', '56789012345'),
  ('57305000', 'Rua do Comércio, 99',   'Poço',         'Maceió',     'AL', '67890123456');
 

INSERT INTO corretora.conta (numero, saldo_disponivel, data_abertura, tipo, cpf_fk) VALUES
  ('CC-001', 15000.00, '2022-01-10', 'PF', '12345678901'),
  ('CC-002', 5000.00,  '2022-03-15', 'PF', '12345678901'), -- Ana com 2 contas
  ('CC-003', 22000.00, '2021-06-20', 'PF', '23456789012'),
  ('CC-004', 8000.00,  '2023-02-01', 'PF', '34567890123'),
  ('CC-005', 50000.00, '2020-11-11', 'PF', '45678901234'),
  ('CC-006', 3000.00,  '2024-01-05', 'PF', '56789012345'),
  ('CC-007', 12000.00, '2023-07-19', 'PJ', '67890123456');
 

INSERT INTO corretora.funcionario (cpf, nome, cargo, salario, data_admissao) VALUES
  ('11122233300', 'Marcos Oliveira',  'Assessor',  5500.00, '2020-03-01'),
  ('22233344400', 'Juliana Alves',    'Assessor',  5800.00, '2019-07-15'),
  ('33344455500', 'Rafael Costa',     'Gerente',   9000.00, '2018-01-10'),
  ('44455566600', 'Patrícia Nunes',   'Assessor',  5200.00, '2021-09-20'),
  ('55566677700', 'Thiago Barros',    'Analista',  6500.00, '2022-04-05');
 

INSERT INTO corretora.assessor (id_funcionario_fk, credenciamento, comissao_percentual) VALUES
  (1, 'CEA-2021', 1.50),
  (2, 'CEA-2019', 1.75),
  (4, 'CEA-2022', 1.25);
 

INSERT INTO corretora.assessor_cliente (id_assessor_fk, cpf_cliente_fk, data_inicio) VALUES
  (1, '12345678901', '2022-01-10'),
  (1, '23456789012', '2022-03-15'),
  (1, '34567890123', '2023-01-20'),
  (2, '45678901234', '2021-01-05'),
  (2, '56789012345', '2024-01-06'),
  (4, '67890123456', '2023-07-20'),
  (1, '56789012345', '2023-06-01'), -- cliente com 2 assessores: caso de borda
  (2, '12345678901', '2023-08-10'),
  (4, '23456789012', '2024-02-14'),
  (4, '45678901234', '2024-03-01');
 

INSERT INTO corretora.ordem (data, tipo, quantidade, status, numero_conta_fk, codigo_ativo_fk) VALUES
  ('2025-05-01 09:00:00', 'compra',  100,  'executada',  'CC-001', 'PETR4'),
  ('2025-05-01 09:05:00', 'compra',  50,   'executada',  'CC-003', 'VALE3'),
  ('2025-05-01 09:10:00', 'compra',  200,  'executada',  'CC-005', 'MXRF11'),
  ('2025-05-01 09:15:00', 'compra',  1,    'executada',  'CC-005', 'BTC'),
  ('2025-05-02 10:00:00', 'venda',   50,   'executada',  'CC-001', 'PETR4'),
  ('2025-05-02 10:05:00', 'compra',  300,  'executada',  'CC-007', 'BOVA11'),
  ('2025-05-02 10:10:00', 'compra',  5,    'executada',  'CC-003', 'ETH'),
  ('2025-05-02 10:15:00', 'compra',  10000,'executada',  'CC-004', 'CDB001'),
  ('2025-05-03 11:00:00', 'compra',  100,  'pendente',   'CC-006', 'PETR4'),
  ('2025-05-03 11:05:00', 'venda',   100,  'cancelada',  'CC-005', 'MXRF11');
 

INSERT INTO corretora.operacao (data, tipo, quantidade, preco_unitario, numero_conta_fk, codigo_ativo_fk, id_ordem_fk) VALUES
  ('2025-05-01 09:00:00', 'compra',  100,   38.10,     'CC-001', 'PETR4',  1),
  ('2025-05-01 09:05:00', 'compra',  50,    62.00,     'CC-003', 'VALE3',  2),
  ('2025-05-01 09:10:00', 'compra',  200,   10.42,     'CC-005', 'MXRF11', 3),
  ('2025-05-01 09:15:00', 'compra',  1,     311000.00, 'CC-005', 'BTC',    4),
  ('2025-05-02 10:00:00', 'venda',   50,    38.52,     'CC-001', 'PETR4',  5),
  ('2025-05-02 10:05:00', 'compra',  300,   112.00,    'CC-007', 'BOVA11', 6),
  ('2025-05-02 10:07:00', 'compra',  5,     15820.00,  'CC-003', 'ETH',    7),
  ('2025-05-02 10:15:00', 'compra',  10000, 1000.00,   'CC-004', 'CDB001', 8),
  ('2025-05-01 09:00:00', 'compra',  50,    38.10,     'CC-003', 'PETR4',  1),
  ('2025-05-02 10:05:00', 'compra',  100,   112.00,    'CC-001', 'BOVA11', 6);
 


INSERT INTO corretora.posicao (quantidade_atual, preco_medio, numero_conta_fk, codigo_ativo_fk) VALUES
  (50,    38.10,     'CC-001', 'PETR4'),  
  (300,   112.00,    'CC-001', 'BOVA11'),
  (50,    62.00,     'CC-003', 'VALE3'),
  (5,     15820.00,  'CC-003', 'ETH'),
  (50,    38.10,     'CC-003', 'PETR4'),
  (200,   10.42,     'CC-005', 'MXRF11'),
  (1,     311000.00, 'CC-005', 'BTC'),
  (300,   112.00,    'CC-007', 'BOVA11');
 

INSERT INTO corretora.rendimento (data, valor, tipo, codigo_ativo_fk) VALUES
  ('2025-05-02', 0.12,    'dividendo',      'PETR4'),
  ('2025-05-02', 0.08,    'dividendo',      'VALE3'),
  ('2025-05-02', 0.09,    'dividendo',      'MXRF11'),
  ('2025-05-02', 250.00,  'rendimento_fixo','CDB001'),
  ('2025-05-02', 180.00,  'rendimento_fixo','LCI001'),
  ('2025-05-02', 0.05,    'jcp',            'PETR4'),
  ('2025-05-02', 0.03,    'jcp',            'VALE3'),
  ('2025-05-02', 0.07,    'dividendo',      'BOVA11');
 

INSERT INTO corretora.rendimento_conta (id_rendimento_fk, numero_conta_fk, valor_creditado) VALUES
  (1, 'CC-001',  6.00),    
  (1, 'CC-003',  6.00),    
  (2, 'CC-003',  4.00),    
  (3, 'CC-005', 18.00),    
  (4, 'CC-004', 250.00),   
  (6, 'CC-001',  2.50),    
  (6, 'CC-003',  2.50),    
  (7, 'CC-003',  1.50),    
  (8, 'CC-001', 21.00),    
  (8, 'CC-007', 21.00);    
