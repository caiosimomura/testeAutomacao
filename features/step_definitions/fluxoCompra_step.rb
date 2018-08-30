#enconding: utf-8

PageObjects = PageObjects.new
FormCadastro = FormCadastro.new

Dado("que eu acesse a loja virtual") do
    visit 'http://www.automationpractice.com'
end
  
Quando("realizo uma compra como usuário prospect") do
    #REALIZO A NAVEGAÇÃO ATÉ O PRODUTO DESEJADO
    PageObjects.menuPrincipalDresses.hover
    PageObjects.submenuCasualDresses.click
    PageObjects.primeiroItemLista.hover
    PageObjects.botaoQuickView.click

    #BUSCAR E GUARDAR INFORMAÇÃO DO TITULO DO PRODUTO NA VARIAVEL @PRODUTO
    listaProduto = Array.new
    listaProduto = PageObjects.listaProdutos.all('li')
    listaProduto.size
    @produto = listaProduto[0].find('.product-name').text
    
    #FLUXO DE COMPRA PELO IFRAME DO PRODUTO
    within_frame(PageObjects.iframeProduto) do
        #GUARDO A INFORMAÇÃO DO PREÇO DO PRODUTO NA VARIAVEL @PRECO_PRODUTO
        @preco_produto = PageObjects.precoProduto.text
        #CLIQUE NO BOTÃO "ADD TO CART" PARA SEGUIR PARA A PROXIMA TELA
        PageObjects.botaoAddToCart.click
    end

    #TELA DE INCLUSAO DO PRODUTO NO CARRINHO COM SUCESSO
    #VALIDA CONFIRMAÇÃO NOME DO PRODUTO
    expect(PageObjects.nomeProdutoToAddCart.text).to eql @produto
    #VALIDA CONFIRMAÇÃO DO VALOR
    expect(PageObjects.precoProdutoToAddCart.text).to eql @preco_produto
    #VALIDA CONFIRMAÇÃO DO VALOR TOTAL DO PRODUTO
    expect(PageObjects.precoTotalProdutoToAddCart.text).to eql @preco_produto

    #REALIZANDO CONVERSÃO DE STRING PARA INT E REPLACE DO VALOR DO PRODUTO
    @preco_produto_replace = @preco_produto.gsub(@preco_produto, "26")
    @preco_produto_replace_int = @preco_produto_replace.to_i

    #REALIZANDO A CONVERSÃO DE STRING PARA INT E REPLACE DO VALOR DO FRETE
    @preco_frete = PageObjects.precoFreteToAddCart.text
    @preco_frete_replace = @preco_frete.gsub(@preco_frete, "2")
    @preco_frete_replace_int = @preco_frete_replace.to_i
    
    #CALCULO DO VALOR FINAL DO PRODUTO + FRETE
    @preco_total_replace = @preco_produto_replace_int + @preco_frete_replace_int

    #REALIZANDO A CONVERSÃO DE INT PARA STRING E REPLACE DO VALOR DO PREÇO TOTAL PARA O FORMATO CORRETO
    @preco_total_replace_string = @preco_total_replace.to_s
    @preco_total = @preco_total_replace_string.gsub(@preco_total_replace_string,"$#{@preco_total_replace_string}.00")

    #VALIDAÇÃO DO PREÇO FINAL DO PRODUTO
    expect(PageObjects.precoTotalToAddCart.text).to eql @preco_total

    #CLIQUE NO BOTÃO "PROCEED TO CHECKOUT" PARA SEGUIR PARA A PRÓXIMA TELA
    PageObjects.botaoProceedToCheckout.click

    #TELA SHOPPING-CART SUMMARY
    #REALIZANDO A VALIDAÇÃO DO CAMPO "Unit price" DA TABELA
    @preco_unid_sumario = PageObjects.precoProdutoSumario.text
    expect(@preco_unid_sumario).to eql @preco_produto

    #REALIZANDO A CONVERSAO DE STRING PARA INT E CALCULO DO VALOR DA QUANTIDADE DO MESMO, PARA REALIZAR A VALIDAÇÃO DO CAMPO "Qty" DA TABELA
    @qtd_pdto_string = PageObjects.qtdProdutoSumario.value
    @qtd_pdto_int = @qtd_pdto_string.to_i
    @valor_qtd_pdto_int = @preco_produto_replace_int * @qtd_pdto_int
    @valor_qtd_pdto_string = @valor_qtd_pdto_int.to_s
    @valor_qtd_pdto_string_replace = @valor_qtd_pdto_string.gsub(@valor_qtd_pdto_string, "$#{@valor_qtd_pdto_string}.00")
    expect(PageObjects.precoTotalUnidProdSumario.text).to eql @valor_qtd_pdto_string_replace

    #VALIDA CAMPO "TOTAL PRODUCTS"
    expect(PageObjects.precoTotalTodosProdutosSumario.text).to eql @valor_qtd_pdto_string_replace

    #VALIDA CAMPO "TOTAL SHIPPING"
    @preco_frete_sumario = PageObjects.precoTotalFreteSumario.text
    expect(@preco_frete_sumario).to eql @preco_frete

    #VALIDA CAMPO "TOTAL" SEM AS TAXAS
    @preco_total_sem_taxa_string = PageObjects.precoTotalSemTaxaSumario.text
    expect(@preco_total_sem_taxa_string).to eql @preco_total

    #REALIZANDO CONVERSAO DE STRING PARA INT E CALCULO VALOR TOTAL SEM TAXAS + TAXAS 
    @preco_total_sem_taxa_replace = @preco_total_sem_taxa_string.gsub(@preco_total_sem_taxa_string, '28')
    @preco_total_sem_taxa_int = @preco_total_sem_taxa_replace.to_i

    @preco_taxa_string = PageObjects.precoTaxaSumario.text
    @preco_taxa_replace = @preco_taxa_string.gsub(@preco_taxa_string, '0')
    @preco_taxa_int = @preco_taxa_string.to_i

    @preco_total_taxa = @preco_total_sem_taxa_int + @preco_taxa_int

    @preco_total_taxa_string = @preco_total_taxa.to_s
    @preco_total_taxa_final = @preco_total_taxa_string.gsub(@preco_total_taxa_string, "$#{@preco_total_taxa_string}.00")
    

    #VALIDA CAMPO "TOTAL" MAIS TAXAS
    @preco_total_taxa_final_sumario = PageObjects.precoTotalComTaxaSumario.text
    expect(@preco_total_taxa_final_sumario).to eql @preco_total_taxa_final

    #CLIQUE NO BOTÃO "PROCEED TO CHECKOUT" PARA SEGUIR PARA A PRÓXIMA TELA
    PageObjects.botaoProceedToCheckout.click

    #TELA DE AUTHENTICATION
    PageObjects.criarEmail.set @email
    PageObjects.botaoCreateAnAccount.click


    #TELA DE YOUR PERSONAL INFORMATION E EFETUAR CADASTRO DE USUÁRIO PROSPECT
    FormCadastro.nomeacao.click
    FormCadastro.primeiroNome.set @primeiroNome
    FormCadastro.sobrenome.set @sobrenome

    #VALIDA SE O EMAIL QUE FOI INFORMADO NA TELA ANTERIOR É A MESMA DO FORMULÁRIO
    expect(FormCadastro.email.value).to eql @email

    FormCadastro.senha.set "12345"
    FormCadastro.diaNasc.select_option
    FormCadastro.mesNasc.select_option
    FormCadastro.anoNasc.select_option
    FormCadastro.informativo.click
    FormCadastro.ofertas.click
    expect(find('#firstname').value).to eql @primeiroNome
    expect(find('#lastname').value).to eql @sobrenome
    FormCadastro.empresa.set @empresa
    FormCadastro.enderecoPrincipal.set @endereco
    FormCadastro.complemento.set @complemento
    FormCadastro.cidade.set @cidade
    @infoEstado = FormCadastro.estado.select_option
    @estado = @infoEstado.text
    FormCadastro.cep.set @cep
    @infoPaís = FormCadastro.país.select_option
    @país = @infoPaís.text
    FormCadastro.infoAdicionais.set 'thank you'
    FormCadastro.telefone.set @telefone
    FormCadastro.celular.set @celular
    FormCadastro.enderecoAlternativo.set @outroEndereco

    PageObjects.registro.click

    #TELA DE ADDRESSES
    #VALIDAÇÃO DE ENDEREÇO DE ENTREGA
    dadosEndEntrega = Array.new
    dadosEndEntrega = PageObjects.enderecoEntrega.all('li')
    dadosEndEntrega.size
    expect(dadosEndEntrega[1].text).to eql "#{@primeiroNome} #{@sobrenome}"
    expect(dadosEndEntrega[2].text).to eql @empresa
    expect(dadosEndEntrega[3].text).to eql "#{@endereco} #{@complemento}"
    expect(dadosEndEntrega[4].text).to eql "#{@cidade}, #{@estado} #{@cep}"
    expect(dadosEndEntrega[5].text).to eql @país
    expect(dadosEndEntrega[6].text).to eql @telefone
    expect(dadosEndEntrega[7].text).to eql @celular

    #VALIDAÇÃO DE ENDEREÇO DE COBRANÇA
    dadosEndEntrega = Array.new
    dadosEndEntrega = PageObjects.enderecoCobranca.all('li')
    dadosEndEntrega.size
    expect(dadosEndEntrega[1].text).to eql "#{@primeiroNome} #{@sobrenome}"
    expect(dadosEndEntrega[2].text).to eql @empresa
    expect(dadosEndEntrega[3].text).to eql "#{@endereco} #{@complemento}"
    expect(dadosEndEntrega[4].text).to eql "#{@cidade}, #{@estado} #{@cep}"
    expect(dadosEndEntrega[5].text).to eql @país
    expect(dadosEndEntrega[6].text).to eql @telefone
    expect(dadosEndEntrega[7].text).to eql @celular

    #CLIQUE NO BOTÃO "PROCEED TO CHECKOUT"
    PageObjects.botaoConfirmEndereco.click

    #VALIDA SE O VALOR DO FRETE É O MESMO INFORMADO NAS TELAS ANTERIORES
    expect(PageObjects.precoFrete.text).to eql @preco_frete

    #CLIQUE NO ACEITE DE TERMOS DE SERVIÇO
    PageObjects.termoAceite.click

    #CLIQUE NO BOTÃO "PROCEED TO CHECKOUT"
    PageObjects.botaoConfirmFrete.click

    ###########           TELA DE "PLEASE CHOOSE YOUR PAYMENT METHOD"          #################
    @preco_total_produto = PageObjects.precoTotalProdPagamento.text
    expect(@preco_total_produto).to eql @preco_unid_sumario
    @preco_total_frete = PageObjects.precoTotalFretePagamento.text
    expect(@preco_total_frete).to eql @preco_frete_sumario
    @preco_total_final = PageObjects.totalPagamento.text
    expect(@preco_total_final).to eql @preco_total_taxa_final_sumario

    PageObjects.meioPagamentoEscolhido.click

    expect(PageObjects.valorConfirmPagamento.text).to eql @preco_total_final

    find('span', text: 'I confirm my order').click
end

Entao("deve mostrar a mensagem {string}") do |string|
    #VALIDAÇÃO DO TÍTULO APRESENTADO DE SUCESSO
    @tituloMsgSucesso = PageObjects.tituloSucesso.text
    expect(@tituloMsgSucesso).to eql string
end
  
Entao("o valor total pago") do
    #VALIDAÇÃO DO VALOR FINAL DA TELA DE SUCESSO
    @valorSucesso = PageObjects.montanteFinal.text
    expect(@valorSucesso).to eql @preco_total_final
end