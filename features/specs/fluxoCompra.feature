#language: pt

@compra
Funcionalidade: Compra via checkout

@dadosProspect
Cenário: Realizar uma compra com sucesso 
        Dado que eu acesse a loja virtual
        Quando realizo uma compra
        Entao deve mostrar a mensagem "Your order on My Store is complete."
        E o valor total pago