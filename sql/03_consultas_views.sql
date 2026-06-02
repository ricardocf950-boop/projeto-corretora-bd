consultas

-- CONSULTA 01 — Seleção simples com filtro
-- Clientes com perfil arrojado
SELECT cpf, nome, email, perfil_risco
FROM corretora.cliente
WHERE perfil_risco = 'arrojado'
ORDER BY nome;
 
-- CONSULTA 02 — Seleção simples com filtro e ordenação
-- Ativos com valor atual acima de R$ 100,00

SELECT a.codigo, a.nome, a.tipo, a.valor_atual, ca.nome AS categoria
FROM corretora.ativo a
JOIN corretora.categoria_ativo ca ON ca.id = a.id_categoria_fk
WHERE a.valor_atual > 100
ORDER BY a.valor_atual DESC;
 

-- CONSULTA 03 — INNER JOIN
-- Operações realizadas com nome do cliente e do ativo

SELECT
    c.nome        AS cliente,
    co.numero     AS conta,
    a.nome        AS ativo,
    op.tipo       AS operacao,
    op.quantidade,
    op.preco_unitario,
    (op.quantidade * op.preco_unitario) AS valor_total,
    op.data
FROM corretora.operacao op
INNER JOIN corretora.conta  co ON co.numero  = op.numero_conta_fk
INNER JOIN corretora.cliente   c  ON c.cpf      = co.cpf_fk
INNER JOIN corretora.ativo      a  ON a.codigo   = op.codigo_ativo_fk
ORDER BY op.data;
 
-- ------------------------------------------------------------
-- CONSULTA 04 — LEFT JOIN
-- Todos os clientes e seus assessores (inclusive sem assessor)
-- ------------------------------------------------------------
SELECT
    c.nome          AS cliente,
    c.perfil_risco,
    f.nome          AS assessor,
    ac.data_inicio
FROM corretora.cliente c
LEFT JOIN corretora.assessor_cliente ac ON ac.cpf_cliente_fk = c.cpf
LEFT JOIN corretora.assessor          as2 ON as2.id_funcionario_fk = ac.id_assessor_fk
LEFT JOIN corretora.funcionario        f  ON f.id = as2.id_funcionario_fk
ORDER BY c.nome;
 

-- CONSULTA 05 — RIGHT JOIN
-- Todos os assessores e seus clientes (inclusive assessores sem clientes)

SELECT
    f.nome              AS assessor,
    f.cargo,
    c.nome              AS cliente,
    ac.data_inicio
FROM corretora.assessor_cliente ac
RIGHT JOIN corretora.assessor    as2 ON as2.id_funcionario_fk = ac.id_assessor_fk
RIGHT JOIN corretora.funcionario f   ON f.id = as2.id_funcionario_fk
LEFT  JOIN corretora.cliente   c   ON c.cpf = ac.cpf_cliente_fk
ORDER BY f.nome;
 
-- ------------------------------------------------------------
-- CONSULTA 06 — Agregação com GROUP BY
-- Volume total operado por ativo (quantidade e valor)
-- ------------------------------------------------------------
SELECT
    a.codigo,
    a.nome                              AS ativo,
    SUM(op.quantidade)                  AS qtd_total,
    SUM(op.quantidade * op.preco_unitario) AS volume_total,
    COUNT(op.id)                        AS num_operacoes
FROM corretora.operacao op
INNER JOIN corretora.ativo a ON a.codigo = op.codigo_ativo_fk
GROUP BY a.codigo, a.nome
ORDER BY volume_total DESC;

-- CONSULTA 07 — Agregação com GROUP BY + HAVING
-- Clientes que acumularam mais de R$ 100,00 em rendimentos

SELECT
    c.nome          AS cliente,
    SUM(rc.valor_creditado) AS total_rendimentos
FROM corretora.rendimento_conta rc
INNER JOIN corretora.conta    co ON co.numero = rc.numero_conta_fk
INNER JOIN corretora.cliente  c  ON c.cpf    = co.cpf_fk
GROUP BY c.nome
HAVING SUM(rc.valor_creditado) > 100
ORDER BY total_rendimentos DESC;
 

-- CONSULTA 08 — Subconsulta NÃO-correlacionada
-- Ativos cujo valor atual está acima da média geral

SELECT codigo, nome, tipo, valor_atual
FROM corretora.ativo
WHERE valor_atual > (
    SELECT AVG(valor_atual) FROM corretora.ativo
)
ORDER BY valor_atual DESC;
 

-- CONSULTA 09 — Subconsulta CORRELACIONADA
-- Clientes que realizaram pelo menos uma operação de compra
-- com valor total acima de R$ 10.000,00

SELECT c.nome, c.perfil_risco
FROM corretora.cliente c
WHERE EXISTS (
    SELECT 1
    FROM corretora.operacao op
    INNER JOIN corretora.conta co ON co.numero = op.numero_conta_fk
    WHERE co.cpf_fk      = c.cpf
      AND op.tipo        = 'compra'
      AND (op.quantidade * op.preco_unitario) > 1000
)
ORDER BY c.nome;
 

-- CONSULTA 10 — Operador de conjunto UNION
-- CPFs que aparecem tanto como clientes quanto como funcionários

SELECT cpf, nome, 'cliente'     AS papel FROM corretora.cliente
UNION
SELECT cpf, nome, 'funcionario' AS papel FROM corretora.funcionario
ORDER BY nome;
 

-- CONSULTA 11 — Extrato completo de uma conta
-- Operações + rendimentos creditados, ordenados por data

SELECT
    op.data,
    'operacao'          AS tipo_lancamento,
    a.nome              AS descricao,
    op.tipo::text       AS movimento, -- Cast para texto para alinhar tipos no UNION se necessário
    (op.quantidade * op.preco_unitario) AS valor
FROM corretora.operacao op
INNER JOIN corretora.ativo a ON a.codigo = op.codigo_ativo_fk
WHERE op.numero_conta_fk = 'CC-001'
 
UNION ALL
 
SELECT
    r.data,
    'rendimento'        AS tipo_lancamento,
    a.nome              AS descricao,
    r.tipo::text        AS movimento,
    rc.valor_creditado  AS valor
FROM corretora.rendimento_conta rc
INNER JOIN corretora.rendimento r ON r.id     = rc.id_rendimento_fk
INNER JOIN corretora.ativo      a ON a.codigo = r.codigo_ativo_fk
WHERE rc.numero_conta_fk = 'CC-001' 
ORDER BY data;
 
-- ------------------------------------------------------------
-- VIEW — Posição consolidada por cliente
-- Mostra carteira atual de cada cliente com valor de mercado
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW corretora.vw_carteira_cliente AS
SELECT
    c.cpf,
    c.nome                                      AS cliente,
    c.perfil_risco,
    co.numero                                   AS conta,
    a.codigo                                    AS ativo,
    a.nome                                      AS nome_ativo,
    ca.nome                                     AS categoria,
    p.quantidade_atual,
    p.preco_medio,
    a.valor_atual                               AS preco_atual,
    (p.quantidade_atual * p.preco_medio)        AS custo_total,
    (p.quantidade_atual * a.valor_atual)        AS valor_mercado,
    (p.quantidade_atual * a.valor_atual)
    - (p.quantidade_atual * p.preco_medio)      AS resultado
FROM corretora.posicao p
INNER JOIN corretora.conta          co ON co.numero  = p.numero_conta_fk
INNER JOIN corretora.cliente        c  ON c.cpf      = co.cpf_fk
INNER JOIN corretora.ativo          a  ON a.codigo   = p.codigo_ativo_fk
INNER JOIN corretora.categoria_ativo ca ON ca.id     = a.id_categoria_fk;
 
-- Consultando a view
SELECT * FROM corretora.vw_carteira_cliente ORDER BY cliente, categoria;
 
-- Resumo por cliente usando a view (Corrigido usando índices de coluna para evitar o erro de agrupamento)
SELECT
    cpf,
    cliente,
    perfil_risco,
    SUM(custo_total)    AS total_investido,
    SUM(valor_mercado)  AS valor_atual_carteira,
    SUM(resultado)      AS resultado_total
FROM corretora.vw_carteira_cliente
GROUP BY 1, 2, 3 
ORDER BY valor_atual_carteira DESC;
