# language: pt

Funcionalidade: Aplicação de cupons de desconto
  Como cliente da Verzel Store
  Quero aplicar e remover cupons no carrinho
  Para obter o desconto previsto nas regras da loja

  Cenário: Aplicar cupom válido com desconto de 10%
    Dado que o carrinho possui produtos com subtotal de R$ 379,80
    Quando aplico o cupom "BEMVINDO10"
    Então o desconto deve ser de R$ 37,98
    E o total deve refletir o desconto aplicado

  Cenário: Aplicar cupom em letras minúsculas
    Dado que o carrinho possui produtos
    Quando aplico o cupom "bemvindo10"
    Então o cupom deve ser aceito
    E o desconto deve ser de 10% do subtotal

  Cenário: Aplicar cupom com espaços externos
    Dado que o carrinho possui produtos
    Quando aplico o cupom " BEMVINDO10 "
    Então os espaços externos devem ser ignorados
    E o cupom deve ser aceito

  Cenário: Aplicar cupom inexistente
    Dado que o carrinho possui produtos
    Quando aplico o cupom "CUPOM123"
    Então deve ser exibida a mensagem "Cupom inválido."
    E nenhum desconto deve ser aplicado

  Cenário: Aplicar cupom expirado
    Dado que o carrinho possui produtos
    Quando aplico o cupom "VERAO2026"
    Então deve ser exibida a mensagem "Cupom expirado."
    E nenhum desconto deve ser aplicado

  Cenário: Remover cupom aplicado
    Dado que o cupom "BEMVINDO10" está aplicado ao carrinho
    Quando removo o cupom
    Então o desconto deve ser removido
    E os valores do carrinho devem ser recalculados

  Cenário: Tentar enviar dois cupons simultaneamente pela API
    Dado que há produtos no carrinho
    Quando envio os códigos "BEMVINDO10" e "VERAO2026" em uma única requisição
    Então a API não deve aplicar dois descontos simultaneamente
    E a resposta deve ser registrada para análise

  Cenário: Tentar trocar por outro cupom válido
    Dado que o cupom "BEMVINDO10" está aplicado ao carrinho
    Quando tento substituí-lo por outro cupom válido
    Então devo remover o cupom atual antes de aplicar outro
    E o desconto deve corresponder somente ao cupom ativo
