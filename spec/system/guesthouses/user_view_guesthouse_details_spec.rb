require 'rails_helper'

describe 'Guest visits guesthouse details page' do
  it 'and sees the correct details' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              complement: 'Térreo',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
      corporate_name: 'Pousada Ramos Faria LTDA',
      registration_number: '02303221000152', phone_number: '1130205000',
      email: 'atendimento@pousadabosque',
      description: 'Pousada tranquila no interior do Rio Grande do Norte',
      payment_method_one: 'Pix', payment_method_two: 'Cartão de crédito',
      payment_method_three: 'Dinheiro', pet_policy: true,
      guesthouse_policy: 'Não é permitido uso de bebida alcoólica',
      checkin_time: '08:00', checkout_time: '20:00',
      address: address, user: user
    )

    guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150,
                             private_bathroom: true, balcony: true,
                             air_conditioning: true, tv: true, closet: true,
                             safe: true, accessibility: true)

    # Act
    visit root_path
    click_on 'Pousada Bosque'

    # Assert
    expect(page).to have_content 'Status: Ativa'
    expect(page).to have_content 'Nome: Pousada Bosque'
    expect(page).not_to have_content 'Razão social: Pousada Ramos Faria LTDA'
    expect(page).not_to have_content 'CNPJ: 02303221000152'
    expect(page).to have_content 'Telefone: 1130205000'
    expect(page).to have_content 'E-mail: atendimento@pousadabosque'
    expect(page).to have_content 'Logradouro: Rua das Pedras'
    expect(page).to have_content 'Número: 30'
    expect(page).to have_content 'Complemento: Térreo'
    expect(page).to have_content 'Bairro: Santa Helena'
    expect(page).to have_content 'CEP: 99000-525'
    expect(page).to have_content 'Cidade: Pulomiranga'
    expect(page).to have_content 'Estado: RN'
    expect(page).to have_content(
      'Descrição: Pousada tranquila no interior do Rio Grande do Norte'
    )
    expect(page).to have_content 'Método de pagamento 1: Pix'
    expect(page).to have_content 'Método de pagamento 2: Cartão de crédito'
    expect(page).to have_content 'Método de pagamento 3: Dinheiro'
    expect(page).to have_content 'Aceita pets'
    expect(page).to have_content(
      'Políticas de uso: Não é permitido uso de bebida alcoólica'
    )
    expect(page).to have_content 'Horário de check-in: 08:00'
    expect(page).to have_content 'Horário de check-out: 20:00'
    expect(page).to have_content 'Brasil'
    expect(page).to have_content 'Quarto com tema Brasil'
    expect(page).to have_content '200 m²'
    expect(page).to have_content 'Capacidade para até 3 pessoa(s)'
    expect(page).to have_content 'Valor da diária: R$ 150,00'
    expect(page).to have_content 'Disponível para reservas'
    expect(page).to have_content 'Banheiro próprio'
    expect(page).to have_content 'Varanda'
    expect(page).to have_content 'Ar-condicionado'
    expect(page).to have_content 'TV'
    expect(page).to have_content 'Guarda-roupas'
    expect(page).to have_content 'Cofre'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
    expect(page).not_to have_link 'Mais detalhes'
    expect(page).not_to have_link 'Adicionar quarto'
  end

  it "doesn't show empty optional attributes" do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)

    # Act
    visit root_path
    click_on 'Pousada Bosque'

    # Assert
    expect(page).not_to have_content 'Complemento'
    expect(page).not_to have_content 'Método de pagamento 1'
    expect(page).not_to have_content 'Método de pagamento 2'
    expect(page).not_to have_content 'Método de pagamento 3'
  end
end

describe 'Host visits own guesthouse details page' do
  it 'and sees edit and inactivate options' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'

    # Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Razão social: Pousada Ramos Faria LTDA'
    expect(page).to have_content 'CNPJ: 02303221000152'
    expect(page).to have_link 'Adicionar quarto'
    expect(page).to have_link 'Editar'
    expect(page).to have_button 'Inativar'
  end
end
