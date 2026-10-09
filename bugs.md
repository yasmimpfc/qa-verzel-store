# Relatório de Bugs — Verzel Store

## BUG-01 — API de cálculo aceita quantidade superior ao limite

- **Critério de aceite:** CA10
- **Severidade sugerida:** Alta
- **Endpoint:** POST /api/carrinho/calcular

**Pré-condição:** API disponível para cálculo do carrinho.

**Passos para reproduzir:**
1. Enviar uma requisição com o produto P001 e quantidade 6.
2. Consultar o status HTTP e o corpo da resposta.

**Resultado esperado:** rejeitar a quantidade com HTTP 422 e erro QUANTIDADE_MAXIMA_EXCEDIDA.

**Resultado obtido:** a API aceitou a quantidade e calculou os valores do carrinho.

**Impacto:** permite ultrapassar a regra de negócio pela API.

---

## BUG-02 — API de pedidos aceita quantidade superior ao limite

- **Critério de aceite:** CA10
- **Severidade sugerida:** Alta
- **Endpoint:** POST /api/pedidos

**Pré-condição:** API de criação de pedidos disponível.

**Passos para reproduzir:**
1. Enviar um pedido válido com o produto P001 em quantidade 6.
2. Consultar o status HTTP e a resposta.

**Resultado esperado:** rejeitar o pedido com HTTP 422 e erro QUANTIDADE_MAXIMA_EXCEDIDA.

**Resultado obtido:** a API criou o pedido e retornou HTTP 201.

**Impacto:** permite criar pedidos em desacordo com o limite de quantidade por produto.

---

## BUG-03 — API calcula frete incorretamente no subtotal de R$ 200,00

- **Critérios de aceite:** CA06 e CA08
- **Severidade sugerida:** Alta
- **Endpoint:** POST /api/carrinho/calcular

**Pré-condição:** API disponível para cálculo do carrinho.

**Passos para reproduzir:**
1. Enviar o produto P005, com preço unitário de R$ 100,00 e quantidade 2.
2. Aplicar o cupom BEMVINDO10.
3. Consultar os valores retornados.

**Resultado esperado:**
- Subtotal: R$ 200,00.
- Desconto: R$ 20,00.
- Frete: R$ 0,00.
- Total: R$ 180,00.
- freteGratis: true.

**Resultado obtido:**
- Subtotal: R$ 200,00.
- Desconto: R$ 20,00.
- Frete: R$ 19,90.
- Total: R$ 199,90.
- freteGratis: false.

**Impacto:** o cliente recebe um cálculo incorreto e pode ser cobrado indevidamente pelo frete.

---

## BUG-04 — Interface cobra frete no subtotal de R$ 200,00

- **Critério de aceite:** CA06
- **Severidade sugerida:** Alta
- **Local:** carrinho da loja.

**Pré-condição:** carrinho com subtotal de R$ 200,00.

**Passos para reproduzir:**
1. Adicionar quatro unidades do produto P008, de R$ 50,00 cada.
2. Acessar o carrinho.
3. Conferir o frete e o total.

**Resultado esperado:** frete grátis, pois o subtotal atinge exatamente R$ 200,00.

**Resultado obtido:** a interface cobrou R$ 19,90 e informou que faltavam R$ 0,00 para o frete grátis.

**Impacto:** o cliente visualiza um valor de frete indevido.

---

## Observações

- Os defeitos BUG-01 e BUG-02 foram observados em endpoints diferentes e devem permanecer separados para facilitar a correção e a retestagem.
- Os defeitos BUG-03 e BUG-04 foram observados na API e na interface, respectivamente.
- As severidades são sugestões iniciais e podem ser ajustadas conforme a classificação adotada pela equipe.
- As evidências visuais e os registros das requisições devem ser associados a cada bug quando disponíveis.
