# Evidências dos Testes - Verzel Store

Esta pasta organiza as evidências dos testes manuais e de API realizados na funcionalidade VZS-142.

## Interface

As capturas devem demonstrar:
- Aplicação e remoção de cupons.
- Validação de cupom inválido e expirado.
- Frete abaixo de R$ 200,00.
- Falha do frete grátis no subtotal de R$ 200,00.
- Limite de cinco unidades por produto.
- Validações de nome, e-mail e CEP no checkout.
- Consistência dos valores entre carrinho e pedido.

## API

As capturas do Postman devem demonstrar:
- Respostas dos endpoints de produtos.
- Validações de quantidade zero e negativa.
- Produto duplicado e produto inexistente.
- Aceitação indevida de mais de cinco unidades.
- Falha no cálculo do frete para subtotal de R$ 200,00.
- Criação de pedido e validação de cupons inválidos ou expirados.

## Convenção de nomes

Utilizar nomes descritivos, por exemplo:
- `ui-frete-limite-200.png`
- `ui-checkout-cep-invalido.png`
- `api-quantidade-maxima-calcular.png`
- `api-quantidade-maxima-pedido.png`
- `api-frete-limite-200.png`

As imagens devem ser reais, capturadas durante a execução. Não registrar como evidência uma captura que não corresponda ao cenário descrito.
