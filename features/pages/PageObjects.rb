#enconding: utf-8

class PageObjects < SitePrism::Page
    set_url "/"

    element :menuPrincipalDresses, "a[title='Dresses']"
    element :submenuCasualDresses, "a[title='Casual Dresses']"
    element :primeiroItemLista, "li[class^='ajax_block_product'"
    element :botaoQuickView, "a[class='quick-view'"
    element :listaProdutos, "ul[class^='product_list']"
    element :iframeProduto, '.fancybox-iframe'
    element :precoProduto, '#our_price_display'
    element :botaoAddToCart, '#add_to_cart'
    element :nomeProdutoToAddCart, '#layer_cart_product_title'
    element :precoProdutoToAddCart, '#layer_cart_product_price'
    element :precoTotalProdutoToAddCart, '.ajax_block_products_total'
    element :precoFreteToAddCart, '.ajax_cart_shipping_cost'
    element :precoTotalToAddCart, '.ajax_block_cart_total'
    element :botaoProceedToCheckout, "a[title='Proceed to checkout']"
    element :precoProdutoSumario, "span[id^='product_price']"
    element :qtdProdutoSumario, "input[class^='cart_quantity_input']"
    element :precoTotalUnidProdSumario, "span[id^='total_product_price']"
    element :precoTotalTodosProdutosSumario, '#total_product'
    element :precoTotalFreteSumario, '#total_shipping'
    element :precoTotalSemTaxaSumario, '#total_price_without_tax'
    element :precoTaxaSumario, '#total_tax'
    element :precoTotalComTaxaSumario, "span[id='total_price']"
    element :criarEmail, '#email_create'
    element :botaoCreateAnAccount, '#SubmitCreate'
    element :registro, '#submitAccount'
    element :enderecoEntrega, '#address_delivery'
    element :enderecoCobranca, '#address_invoice'
    element :botaoConfirmEndereco, "button[name='processAddress']"
    element :precoFrete, "div[class='delivery_option_price']"
    element :termoAceite, '#uniform-cgv'
    element :botaoConfirmFrete, "button[name='processCarrier']"
    element :precoTotalProdPagamento, '#total_product'
    element :precoTotalFretePagamento, '#total_shipping'
    element :totalPagamento, "span[id='total_price']"
    element :meioPagamentoEscolhido, ".bankwire"
    element :valorConfirmPagamento, '#amount'
    element :tituloSucesso, '.cheque-indent'
    element :montanteFinal, '.price'
end