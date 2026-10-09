# language: pt

Funcionalidade: Cálculo do frete
  Como cliente da Verzel Store
  Quero visualizar o valor correto do frete
  Para saber o custo total da minha compra

  Cenário: Cobrar frete abaixo de R$ 200,00
    Dado que o subtotal dos produtos é R$ 199,50
    Quando o sistema calcular o frete
    Então o frete deve ser de R$ 19,90
    E o carrinho deve informar que faltam R$ 0,50 para o frete grátis

  Cenário: Aplicar frete grátis no subtotal de R$ 200,00
    Dado que o subtotal dos produtos é R$ 200,00
    Quando o sistema calcular o frete
    Então o frete deve ser R$ 0,00
    E o frete deve ser identificado como grátis

  Cenário: Aplicar frete grátis acima de R$ 200,00
    Dado que o subtotal dos produtos é superior a R$ 200,00
    Quando o sistema calcular o frete
    Então o frete deve ser R$ 0,00

  Cenário: Considerar o subtotal antes do desconto do cupom
    Dado que o subtotal dos produtos é R$ 200,00
    E o cupom "BEMVINDO10" concede 10% de desconto
    Quando o sistema calcular o frete
    Então o frete deve ser grátis
    E o desconto deve ser de R$ 20,00

  Cenário: Não aplicar desconto do cupom sobre o frete
    Dado que o subtotal dos produtos é R$ 109,80
    E o cupom "BEMVINDO10" está aplicado
    Quando o sistema calcular o total
    Então o desconto deve ser de R$ 10,98
    E o frete deve permanecer em R$ 19,90
    E o total deve ser R$ 118,72
