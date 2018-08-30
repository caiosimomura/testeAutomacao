#language: pt

@compra
Funcionalidade: Compra via checkout com usuário prospect

@dadosProspect
Cenário: Realizar uma compra com um usuário prospect com sucesso 
        Dado que eu acesse a loja virtual
        Quando realizo uma compra como usuário prospect
        Entao deve mostrar a mensagem "Your order on My Store is complete."
        E o valor total pago