#enconding: utf-8

class FormCadastro < SitePrism::Page
    set_url "/"

    element :nomeacao, '#id_gender1'
    element :primeiroNome, '#customer_firstname'
    element :sobrenome , '#customer_lastname'
    element :email, '#email'
    element :senha, '#passwd'
    element :diaNasc, "#uniform-days option[value='3']"
    element :mesNasc, "#uniform-months option[value='2']"
    element :anoNasc, "#uniform-years option[value='1988']"
    element :informativo, '#uniform-newsletter'
    element :ofertas, '#uniform-optin'
    element :empresa, '#company'
    element :enderecoPrincipal, '#address1'
    element :complemento, '#address2'
    element :cidade, '#city'
    element :estado, "#uniform-id_state option[value='32']"
    element :cep, '#postcode'
    element :país, "#uniform-id_country option[value='21']"
    element :infoAdicionais, '#other'
    element :telefone, '#phone'
    element :celular, '#phone_mobile'
    element :enderecoAlternativo, '#alias'
end