Dado("que eu acesse a loja virtual") do
    visit 'http://www.automationpractice.com'
    @email = Faker::Internet.email
    @primeiroNome = Faker::Name.first_name
    @sobrenome = Faker::Name.last_name
    @empresa = Faker::Company.name
    @endereco = Faker::Address.street_address
    @complemento = Faker::Address.secondary_address
    @cidade = Faker::Address.city
    @cep = '10004'
    @telefone = '202-555-0128'
    @celular = Faker::PhoneNumber.cell_phone
    @outroEndereco = Faker::Address.street_address
end
  
Quando("realizo uma compra") do
    find("a[title='Dresses']").hover
    find("a[title='Casual Dresses']").click
    find("li[class^='ajax_block_product'").hover
    find("a[class='quick-view'").click

    within_frame(find('.fancybox-iframe')) do
        @descricao_produto = find("div[class^='pb-center-column'").text
        find('#add_to_cart').click
        @preço_produto = find('#our_price_display').text
    end

    find('a[title="Proceed to checkout"').click
    find('a[title="Proceed to checkout"').click

    find('#email_create').set @email
    find('#SubmitCreate').click

    find('#id_gender1').click
    find('#customer_firstname').set @primeiroNome
    find('#customer_lastname').set @sobrenome
    expect(find('#email').value).to eql @email
    find('#passwd').set "12345"
    find("#uniform-days option[value='3']").select_option
    find("#uniform-months option[value='2']").select_option
    find("#uniform-years option[value='1988']").select_option
    find('#uniform-newsletter').click
    find('#uniform-optin').click
    find('#firstname').set @primeiroNome
    find('#lastname').set @sobrenome
    find('#company').set @empresa
    find('#address1').set @endereco
    find('#address2').set @complemento
    find('#city').set @cidade
    @infoEstado = find("#uniform-id_state option[value='32']").select_option
    @estado = @infoEstado.text
    find('#postcode').set @cep
    @infoPaís = find("#uniform-id_country option[value='21']").select_option
    @país = @infoPaís.text
    find('#other').set 'thank you'
    find('#phone').set @telefone
    find('#phone_mobile').set @celular
    find('#alias').set @outroEndereco
    find('#submitAccount').click


    #VALIDAÇÃO DE ENDEREÇO DE ENTREGA
    dadosEndEntrega = Array.new
    dadosEndEntrega = find('#address_delivery').all('li')
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
    dadosEndEntrega = find('#address_invoice').all('li')
    dadosEndEntrega.size
    expect(dadosEndEntrega[1].text).to eql "#{@primeiroNome} #{@sobrenome}"
    expect(dadosEndEntrega[2].text).to eql @empresa
    expect(dadosEndEntrega[3].text).to eql "#{@endereco} #{@complemento}"
    expect(dadosEndEntrega[4].text).to eql "#{@cidade}, #{@estado} #{@cep}"
    expect(dadosEndEntrega[5].text).to eql @país
    expect(dadosEndEntrega[6].text).to eql @telefone
    expect(dadosEndEntrega[7].text).to eql @celular

    find("button[name='processAddress']").click

    find('#uniform-cgv').click
    find("button[name='processCarrier'").click

    @valorTotal = find("#total_price").text
    #ajustar depois
    expect(@valorTotal).to eql "$28.00"

    find(".bankwire").click

    find('span', text: 'I confirm my order').click
    sleep 5
end


Entao("deve mostrar a mensagem {string}") do |string|
    #VALIDAÇÃO DO TÍTULO APRESENTADO DE SUCESSO
    @tituloMsgSucesso = find('.cheque-indent').text
    expect(@tituloMsgSucesso).to eql string
end
  
Entao("o valor total pago") do
    #VALIDAÇÃO DO VALOR FINAL DA TELA DE SUCESSO
    @valorSucesso = find('.price').text
    expect(@valorSucesso).to eql @valorTotal
end