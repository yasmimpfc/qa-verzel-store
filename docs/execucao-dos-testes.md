# Relatório de Execução de Testes — Verzel Store

## 1. Identificação

- **Funcionalidade:** VZS-142 — Cupom de desconto e frete grátis
- **Ambiente:** Verzel Store — ambiente de teste técnico
- **Testes de interface:** execução manual e exploratória
- **Testes de API:** Postman
- **Data da execução:** 08/10/2026
- **Objetivo:** validar os critérios de aceitação, registrar os resultados observados e identificar defeitos.

## 2. Resumo da execução

Os testes foram realizados na interface da loja e nos endpoints de produtos, cálculo do carrinho e criação de pedidos.

Foram identificadas falhas na regra de frete grátis para subtotal de R$ 200,00 e na validação do limite de cinco unidades por produto na API.

## 3. Testes manuais — Interface

| ID | Cenário | Resultado obtido | Status |
|---|---|---|---|
| CT-M01 | Aplicar cupom inexistente | Mensagem "Cupom inválido." e nenhum desconto | PASSOU |
| CT-M02 | Aplicar cupom expirado | Mensagem "Cupom expirado." e nenhum desconto | PASSOU |
| CT-M03 | Aplicar cupom em letras minúsculas | Cupom aceito | PASSOU |
| CT-M04 | Aplicar cupom com espaços externos | Cupom aceito, ignorando espaços | PASSOU |
| CT-M05 | Remover cupom | Desconto removido e valores recalculados | PASSOU |
| CT-M06 | Frete abaixo de R$ 200,00 | Frete de R$ 19,90 e indicação de R$ 0,50 restantes para o limite | PASSOU |
| CT-M07 | Frete com subtotal de R$ 200,00 | Interface cobrou R$ 19,90 indevidamente | FALHOU |
| CT-M08 | Limite de cinco unidades na interface | Interface impediu a sexta unidade | PASSOU |
| CT-M09 | Carrinho vazio | Mensagem "Seu carrinho está vazio" | PASSOU |
| CT-M10 | Nome sem sobrenome | Nome "Maria" rejeitado com mensagem de validação | PASSOU |
| CT-M11 | E-mail inválido | E-mail "maria@exemplo" rejeitado | PASSOU |
| CT-M12 | CEP incompleto | CEP com cinco dígitos rejeitado | PASSOU |
| CT-M13 | CEP com hífen | CEP aceito e pedido criado | PASSOU |
| CT-M14 | CEP sem hífen | CEP aceito | PASSOU |
| CT-M15 | Consistência entre carrinho e pedido | Subtotal, desconto, frete, total e quantidades mantidos | PASSOU |
| CT-M16 | Valores monetários com duas casas decimais | Valores observados corretos nos cenários executados; frações de centavo não isoladas | PARCIAL |
| CT-M17 | Pagamento online | Não existe opção de pagamento online no fluxo apresentado | PASSOU |

## 4. Testes de API — Postman

| ID | Cenário | Resultado obtido | Status |
|---|---|---|---|
| CT-API01 | GET /api/produtos | HTTP 200 e oito produtos retornados | PASSOU |
| CT-API02 | GET /api/produtos/P001 | HTTP 200 e dados do produto | PASSOU |
| CT-API03 | GET /api/produtos/P999 | HTTP 404 — PRODUTO_NAO_ENCONTRADO | PASSOU |
| CT-API04 | DELETE /api/produtos/P001 | HTTP 405 — método não permitido | PASSOU |
| CT-API05 | Quantidade zero no cálculo | HTTP 422 — QUANTIDADE_INVALIDA | PASSOU |
| CT-API06 | Quantidade negativa no cálculo | HTTP 422 — QUANTIDADE_INVALIDA | PASSOU |
| CT-API07 | Produto duplicado no carrinho | HTTP 422 — ITEM_DUPLICADO | PASSOU |
| CT-API08 | Produto inexistente no carrinho | HTTP 422 — PRODUTO_NAO_ENCONTRADO | PASSOU |
| CT-API09 | Lista de itens vazia ou ausente | HTTP 422 — ITENS_OBRIGATORIOS | PASSOU |
| CT-API10 | Criar pedido com dados válidos | HTTP 201 | PASSOU |
| CT-API11 | Criar pedido com cupom expirado | HTTP 422 — CUPOM_EXPIRADO | PASSOU |
| CT-API12 | Criar pedido com cupom inexistente | HTTP 422 — CUPOM_INVALIDO | PASSOU |
| CT-API13 | Quantidade acima de cinco no cálculo | API aceitou quantidades de seis, sete e oito unidades | FALHOU |
| CT-API14 | Criar pedido com quantidade acima de cinco | API criou pedidos com seis e sete unidades, HTTP 201 | FALHOU |
| CT-API15 | Frete com subtotal de R$ 200,00 e cupom | API cobrou R$ 19,90 de frete e retornou total incorreto | FALHOU |
| CT-API16 | Cálculo com subtotal de R$ 109,80 e cupom | Desconto de R$ 10,98, frete de R$ 19,90 e total de R$ 118,72 | PASSOU |
| CT-API17 | Envio simultâneo de dois cupons | API retornou cupom inválido, sem aplicar desconto | PASSOU |

## 5. Defeitos identificados

### BUG-01 — API de cálculo aceita quantidade superior ao limite

- **Critério:** CA10.
- **Endpoint:** POST /api/carrinho/calcular.
- **Esperado:** rejeitar quantidade superior a cinco com QUANTIDADE_MAXIMA_EXCEDIDA.
- **Obtido:** aceitou quantidades de seis, sete e oito unidades e calculou o carrinho.

### BUG-02 — API de pedidos aceita quantidade superior ao limite

- **Critério:** CA10.
- **Endpoint:** POST /api/pedidos.
- **Esperado:** rejeitar pedido com quantidade superior a cinco.
- **Obtido:** criou pedidos com seis e sete unidades, retornando HTTP 201.

### BUG-03 — API calcula frete incorretamente no limite de R$ 200,00

- **Critérios:** CA06 e CA08.
- **Endpoint:** POST /api/carrinho/calcular.
- **Esperado:** frete grátis quando o subtotal antes do desconto é de R$ 200,00.
- **Obtido:** com subtotal de R$ 200,00 e desconto de R$ 20,00, retornou frete de R$ 19,90, freteGratis false e total de R$ 199,90. O total esperado era R$ 180,00.

### BUG-04 — Interface cobra frete no subtotal de R$ 200,00

- **Critério:** CA06.
- **Local:** carrinho da loja.
- **Esperado:** frete grátis a partir de R$ 200,00, inclusive.
- **Obtido:** a interface cobrou R$ 19,90 mesmo com subtotal de R$ 200,00.

## 6. Critérios com validação parcial ou não concluída

- **CA05 — Troca entre cupons válidos:** a remoção do cupom atual foi validada. Não foi possível concluir a troca para outro cupom válido porque o ambiente não disponibiliza um segundo cupom válido. O envio simultâneo de dois códigos pela API foi testado e retornou "Cupom inválido.".
- **CA11 — Arredondamento:** os valores observados apresentaram duas casas decimais nos cenários executados. Não foi isolado um cenário com fração de centavo para comprovar todas as regras de arredondamento.
- **Pagamento:** o checkout não oferece opção de pagamento online; não foi realizado pagamento real, pois o ambiente é de teste.

## 7. Observações finais

- Os pedidos gerados no ambiente são fictícios e não representam compras reais.
- Os resultados registrados correspondem aos cenários executados; cenários não executados não devem ser considerados aprovados.
- As evidências visuais serão organizadas separadamente no repositório.
- Os cenários BDD estão na pasta `features`.
- A automação com Playwright permanece como uma entrega pendente.

