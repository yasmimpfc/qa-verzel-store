# language: pt

Funcionalidade: Validação do carrinho de compras
  Como cliente da Verzel Store
  Quero adicionar produtos e atualizar quantidades
  Para conferir os valores antes de finalizar a compra

  Cenário: Exibir carrinho vazio
    Dado que não há produtos no carrinho
    Quando acesso o carrinho
    Então deve ser exibida a mensagem "Seu carrinho está vazio"

  Cenário: Recalcular valores após alterar quantidades
    Dado que há produtos no carrinho
    E o cupom "BEMVINDO10" está aplicado
    Quando altero a quantidade de um produto
    Então o subtotal deve ser recalculado
    E o desconto deve corresponder a 10% do subtotal
    E o total deve ser atualizado corretamente

  Cenário: Impedir mais de 5 unidades na interface
    Dado que há um produto no carrinho com 5 unidades
    Quando tento adicionar a sexta unidade pela interface
    Então a quantidade não deve ultrapassar 5

  Cenário: Rejeitar quantidade superior a 5 no cálculo da API
    Dado que envio um produto com quantidade 6
    Quando solicito o cálculo do carrinho pela API
    Então a API deve rejeitar a quantidade
    E deve retornar o erro "QUANTIDADE_MAXIMA_EXCEDIDA"

  Cenário: Rejeitar pedido com quantidade superior a 5 na API
    Dado que envio um pedido com um produto em quantidade 6
    Quando solicito a criação do pedido pela API
    Então o pedido deve ser rejeitado
    E deve retornar o erro "QUANTIDADE_MAXIMA_EXCEDIDA"

  Cenário: Rejeitar quantidade zero na API
    Dado que envio um produto com quantidade 0
    Quando solicito o cálculo do carrinho pela API
    Então deve retornar HTTP 422
    E deve retornar o erro "QUANTIDADE_INVALIDA"

  Cenário: Rejeitar quantidade negativa na API
    Dado que envio um produto com quantidade -1
    Quando solicito o cálculo do carrinho pela API
    Então deve retornar HTTP 422
    E deve retornar o erro "QUANTIDADE_INVALIDA"

  Cenário: Rejeitar produto inexistente na API
    Dado que envio o produto "P999"
    Quando solicito o cálculo do carrinho pela API
    Então deve retornar HTTP 422
    E deve retornar o erro "PRODUTO_NAO_ENCONTRADO"

  Cenário: Rejeitar produto duplicado na API
    Dado que envio o mesmo produto em dois itens
    Quando solicito o cálculo do carrinho pela API
    Então deve retornar HTTP 422
    E deve retornar o erro "ITEM_DUPLICADO"

  Cenário: Rejeitar carrinho sem itens na API
    Dado que envio uma lista de itens vazia
    Quando solicito o cálculo do carrinho pela API
    Então deve retornar HTTP 422
    E deve retornar o erro "ITENS_OBRIGATORIOS"
