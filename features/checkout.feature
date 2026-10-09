# language: pt

 Funcionalidade: Validação do checkout
  Como cliente da Verzel Store
  Quero informar meus dados corretamente
  Para finalizar meu pedido

  Cenário: Exigir nome e sobrenome
    Dado que estou no checkout
    Quando informo o nome "Maria"
    E preencho os demais campos obrigatórios corretamente
    E tento finalizar a compra
    Então o pedido não deve ser criado
    E deve ser exibida a mensagem "Informe nome e sobrenome."

  Cenário: Rejeitar e-mail inválido
    Dado que estou no checkout
    Quando informo o e-mail "maria@exemplo"
    E preencho os demais campos obrigatórios corretamente
    E tento finalizar a compra
    Então o pedido não deve ser criado
    E deve ser exibida a mensagem "Informe um e-mail válido."

  Cenário: Rejeitar CEP incompleto
    Dado que estou no checkout
    Quando informo o CEP "12345"
    E preencho os demais campos obrigatórios corretamente
    E tento finalizar a compra
    Então o pedido não deve ser criado
    E deve ser exibida a mensagem "Informe um CEP com 8 dígitos."

  Cenário: Aceitar CEP com hífen
    Dado que estou no checkout
    Quando informo o CEP "01310-100"
    E preencho os demais campos obrigatórios corretamente
    E finalizo a compra
    Então o pedido deve ser criado
    E o CEP deve ser aceito

  Cenário: Aceitar CEP sem hífen
    Dado que estou no checkout
    Quando informo o CEP "01310100"
    E preencho os demais campos obrigatórios corretamente
    E finalizo a compra
    Então o pedido deve ser criado
    E o CEP deve ser aceito

  Cenário: Exigir os campos obrigatórios
    Dado que estou no checkout
    Quando tento finalizar a compra sem preencher os campos obrigatórios
    Então o sistema deve solicitar o preenchimento dos dados necessários
    E o pedido não deve ser criado

  Cenário: Confirmar os valores do pedido
    Dado que o carrinho possui produtos e um cupom aplicado
    Quando finalizo a compra com dados válidos
    Então subtotal, desconto, frete e total devem corresponder ao carrinho
    E as quantidades dos produtos devem ser mantidas

  Cenário: Não oferecer pagamento online
    Dado que estou no checkout
    Quando visualizo as opções de finalização
    Então não deve ser disponibilizada opção de pagamento online
    E a compra deve seguir o fluxo previsto pelo ambiente de teste
