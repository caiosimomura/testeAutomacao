Before '@dadosProspect' do
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