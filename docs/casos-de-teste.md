# Casos de Teste - Verzel Store

## 1. Objetivo

Documentar os cenários de teste manuais e de API executados na funcionalidade VZS-142 — Cupom de desconto e frete grátis, registrando resultados esperados, resultados obtidos e defeitos identificados.

## 2. Escopo

- Aplicação, remoção e validação de cupons.
- Desconto de 10% sobre o subtotal dos produtos.
- Validação de cupons inválidos e expirados.
- Normalização de códigos de cupom: maiúsculas, minúsculas e espaços externos.
- Tentativa de aplicação simultânea de cupons.
- Cálculo de subtotal, desconto, frete e total.
- Frete grátis para subtotal a partir de R$ 200,00, inclusive.
- Valor restante para atingir o limite de frete grátis.
- Validação de que o desconto não incide sobre o frete.
- Limite de 5 unidades por produto na interface e na API.
- Carrinho vazio, atualização de quantidades e recálculo dos valores.
- Validação dos dados do checkout: nome, sobrenome, e-mail e CEP.
- Validação de CEP com e sem hífen.
- Campos obrigatórios para finalização do pedido.
- Criação de pedidos e consistência dos valores entre carrinho e pedido.
- Observação do comportamento relacionado ao pagamento.
- Consulta de produtos, cálculo do carrinho e criação de pedidos pela API.
- Validação de erros para quantidades inválidas, itens duplicados, produtos inexistentes, ausência de itens e método HTTP não permitido.
- Conferência dos valores monetários com duas casas decimais nos cenários executados.

## 3. Convenções de resultado

- **PASSOU:** o comportamento observado correspondeu ao esperado no cenário executado.
- **FALHOU:** o comportamento observado divergiu do esperado.
- **NÃO APLICÁVEL:** o cenário não pode ser executado no ambiente disponível.
- **LIMITAÇÃO DE COBERTURA:** o comportamento foi observado em cenários específicos, sem comprovar todas as possibilidades.

## 4. Casos de Teste Manuais - Interface

| ID | Cenário | Resultado esperado | Resultado obtido | Status |
|---|---|---|---|---|
| CT-M01 | Aplicar cupom inexistente | Exibir “Cupom inválido.” sem desconto | Mensagem exibida e nenhum desconto aplicado | PASSOU |
| CT-M02 | Aplicar cupom expirado | Exibir “Cupom expirado.” sem desconto | Mensagem exibida e nenhum desconto aplicado | PASSOU |
| CT-M03 | Aplicar cupom em letras minúsculas | Aceitar o código sem diferenciar maiúsculas e minúsculas | Cupom aplicado corretamente | PASSOU |
| CT-M04 | Aplicar cupom com espaços externos | Ignorar espaços antes e depois do código | Cupom aplicado corretamente | PASSOU |
| CT-M05 | Remover cupom aplicado | Remover desconto e recalcular valores | Remoção e recálculo corretos | PASSOU |
| CT-M06 | Aplicar BEMVINDO10 | Aplicar 10% de desconto sobre o subtotal dos produtos | Subtotal de R$ 379,80 e desconto de R$ 37,98 | PASSOU |
| CT-M07 | Calcular frete abaixo de R$ 200,00 | Cobrar R$ 19,90 e informar quanto falta para frete grátis | Subtotal de R$ 199,50, frete de R$ 19,90 e indicação de R$ 0,50 restantes | PASSOU |
| CT-M08 | Calcular frete com subtotal de R$ 200,00 | Aplicar frete grátis | Interface cobrou R$ 19,90 e indicou R$ 0,00 restantes | FALHOU |
| CT-M09 | Validar limite de quantidade na interface | Impedir mais de 5 unidades por produto | Interface impediu a sexta unidade | PASSOU |
| CT-M10 | Validar carrinho vazio | Informar que o carrinho está vazio | Mensagem “Seu carrinho está vazio” e contador zerado | PASSOU |
| CT-M11 | Atualizar quantidades com cupom aplicado | Recalcular subtotal, desconto, frete e total | Recálculos consistentes nos cenários executados | PASSOU |
| CT-M12 | Validar nome incompleto no checkout | Exigir nome e sobrenome | Nome “Maria” rejeitado com mensagem de validação | PASSOU |
| CT-M13 | Validar e-mail inválido | Rejeitar formato inválido | E-mail `maria@exemplo` rejeitado | PASSOU |
| CT-M14 | Validar CEP incompleto | Exigir 8 dígitos | CEP com 5 dígitos rejeitado | PASSOU |
| CT-M15 | Validar CEP com hífen | Aceitar CEP válido formatado | CEP aceito e pedido criado | PASSOU |
| CT-M16 | Validar CEP sem hífen | Aceitar CEP válido sem formatação | CEP aceito | PASSOU |
| CT-M17 | Validar campos obrigatórios do checkout | Impedir finalização sem os dados obrigatórios | Validações de nome, e-mail e CEP observadas | PASSOU NOS CENÁRIOS EXECUTADOS |
| CT-M18 | Conferir valores entre carrinho e pedido | Manter subtotal, desconto, frete, total e quantidades consistentes | Subtotal de R$ 409,10, desconto de R$ 40,91, frete grátis e total de R$ 368,19 mantidos no pedido | PASSOU |
| CT-M19 | Conferir valores monetários | Exibir valores com duas casas decimais | Valores observados corretos nos cenários executados | PASSOU NOS CENÁRIOS EXECUTADOS |
| CT-M20 | Verificar opção de pagamento online | Não disponibilizar pagamento online conforme o comportamento esperado | Não foi encontrada opção de pagamento online na interface | COMPORTAMENTO OBSERVADO |

## 5. Casos de Teste de API — Produtos e Validações

| ID | Endpoint / cenário | Resultado esperado | Resultado obtido | Status |
|---|---|---|---|---|
| CT-API01 | GET /api/produtos | Retornar produtos cadastrados | 8 produtos retornados | PASSOU |
| CT-API02 | GET /api/produtos/P001 | Retornar produto existente | HTTP 200 com dados do produto | PASSOU |
| CT-API03 | GET /api/produtos/P999 | Retornar erro para produto inexistente | HTTP 404 — PRODUTO_NAO_ENCONTRADO | PASSOU |
| CT-API04 | DELETE /api/produtos/P001 | Rejeitar método não permitido | HTTP 405 | PASSOU |
| CT-API05 | POST /api/carrinho/calcular com quantidade zero | Rejeitar quantidade inválida | HTTP 422 — QUANTIDADE_INVALIDA | PASSOU |
| CT-API06 | POST /api/carrinho/calcular com quantidade negativa | Rejeitar quantidade inválida | HTTP 422 — QUANTIDADE_INVALIDA | PASSOU |
| CT-API07 | POST /api/carrinho/calcular com produto duplicado | Rejeitar item duplicado | HTTP 422 — ITEM_DUPLICADO | PASSOU |
| CT-API08 | POST /api/carrinho/calcular com produto inexistente | Rejeitar produto inválido | HTTP 422 — PRODUTO_NAO_ENCONTRADO | PASSOU |
| CT-API09 | POST /api/carrinho/calcular sem itens | Rejeitar lista vazia ou ausente | HTTP 422 — ITENS_OBRIGATORIOS | PASSOU |
| CT-API10 | POST /api/carrinho/calcular com cupom inválido | Calcular carrinho sem desconto e informar o erro | HTTP 200, desconto zero e mensagem “Cupom inválido.” | PASSOU |
| CT-API11 | POST /api/carrinho/calcular com dois cupons enviados em array | Não aplicar dois descontos simultaneamente | API interpretou a combinação como um único código inválido e não aplicou desconto | PASSOU |
| CT-API12 | POST /api/carrinho/calcular com P006 e BEMVINDO10 | Aplicar 10% de desconto sobre R$ 29,90 | Desconto de R$ 2,99 | PASSOU |
| CT-API13 | POST /api/carrinho/calcular com subtotal de R$ 109,80 e cupom | Aplicar 10% de desconto, frete de R$ 19,90 e total correto | Desconto de R$ 10,98 e total de R$ 118,72 | PASSOU |

## 6. Casos de Teste de API — Pedidos e Regras de Negócio

| ID | Endpoint / cenário | Resultado esperado | Resultado obtido | Status |
|---|---|---|---|---|
| CT-API14 | POST /api/pedidos com dados válidos | Criar pedido | HTTP 201 | PASSOU |
| CT-API15 | POST /api/pedidos com cupom expirado | Rejeitar pedido | HTTP 422 — CUPOM_EXPIRADO | PASSOU |
| CT-API16 | POST /api/pedidos com cupom inexistente | Rejeitar pedido | HTTP 422 — CUPOM_INVALIDO | PASSOU |
| CT-API17 | POST /api/carrinho/calcular com quantidade acima de 5 | Rejeitar quantidade acima do limite | API aceitou quantidades de 6, 7 e 8 unidades e calculou o carrinho | FALHOU |
| CT-API18 | POST /api/pedidos com quantidade acima de 5 | Rejeitar pedido acima do limite | API criou pedidos com quantidades de 6 e 7 unidades, retornando HTTP 201 | FALHOU |
| CT-API19 | POST /api/carrinho/calcular com subtotal de R$ 200,00 e cupom | Aplicar frete grátis sobre o subtotal anterior ao desconto | API retornou desconto de R$ 20,00, frete de R$ 19,90, `freteGratis: false`, valor faltante zero e total de R$ 199,90 | FALHOU |

## 7. Defeitos Identificados

### BUG-01 — Interface cobra frete com subtotal de R$ 200,00

- **Critério relacionado:** CA06.
- **Resultado esperado:** frete grátis para subtotal igual ou superior a R$ 200,00.
- **Resultado obtido:** cobrança de R$ 19,90 e indicação de R$ 0,00 restantes.
- **Impacto:** valor final apresentado ao cliente incorreto.

### BUG-02 — API calcula frete incorretamente no limite de R$ 200,00

- **Critérios relacionados:** CA06 e CA08.
- **Endpoint:** POST /api/carrinho/calcular.
- **Resultado esperado:** frete zero quando o subtotal dos produtos atinge R$ 200,00, mesmo com desconto de cupom.
- **Resultado obtido:** subtotal de R$ 200,00, desconto de R$ 20,00, frete de R$ 19,90 e total de R$ 199,90.
- **Impacto:** cálculo financeiro divergente da regra de negócio.

### BUG-03 — API de cálculo aceita mais de 5 unidades por produto

- **Critério relacionado:** CA10.
- **Endpoint:** POST /api/carrinho/calcular.
- **Resultado esperado:** rejeitar quantidade superior a 5 com erro `QUANTIDADE_MAXIMA_EXCEDIDA`.
- **Resultado obtido:** API aceitou quantidades de 6, 7 e 8 unidades e retornou o cálculo.
- **Impacto:** regra de quantidade não aplicada no backend.

### BUG-04 — API de pedidos aceita mais de 5 unidades por produto

- **Critério relacionado:** CA10.
- **Endpoint:** POST /api/pedidos.
- **Resultado esperado:** rejeitar pedido com quantidade superior a 5.
- **Resultado obtido:** API criou pedidos com quantidades de 6 e 7 unidades, retornando HTTP 201.
- **Impacto:** criação de pedidos em desacordo com a regra de negócio.

## 8. Critérios Não Aplicáveis e Limitações

- **CA05 — Troca entre cupons válidos:** a remoção do cupom foi validada. A tentativa de enviar dois cupons simultaneamente pela API foi tratada como cupom inválido. A troca entre dois cupons válidos não pôde ser testada porque o ambiente disponibiliza apenas um cupom válido.
- **CA11 — Arredondamento:** os valores observados estavam corretos com duas casas decimais nos cenários executados. Não foram isolados todos os casos matemáticos de arredondamento.
- **Pagamento:** não foi encontrada opção de pagamento online na interface. Essa observação não comprova, isoladamente, todo o fluxo de pagamento na entrega.
- **Endereço:** o CEP foi validado com e sem hífen, além do cenário de CEP incompleto. Não afirmar validação individual de todos os campos de endereço sem evidência específica.
- **BDD/Gherkin:** os cenários serão organizados em arquivos `.feature` separados, agrupados por cupons, frete, carrinho e checkout.
- **Automação:** os cenários automatizados com Playwright serão documentados separadamente após sua execução.

## 9. Resultado Geral

Os cenários principais dos critérios de aceitação foram exercitados na interface e na API, conforme aplicável. Foram identificados quatro registros de defeito relacionados ao cálculo de frete grátis e ao limite máximo de unidades por produto.

Os resultados refletem os cenários executados e as evidências disponíveis. Os defeitos deverão ser corrigidos e retestados. Cenários não aplicáveis e limitações de cobertura permanecem explicitamente registrados.
