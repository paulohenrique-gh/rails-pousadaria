require 'rails_helper'

describe 'User searches for a guesthouse' do
  it 'from the home page' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'senhasecreta')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99004-100')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosques Verdes',
                               corporate_name: 'Santa Bárbara Hotelaria LTDA',
                               registration_number: '02303221000152',
                               phone_number: '1130205000',
                               email: 'atendimento@pousadabosque',
                               checkin_time: '08:00', checkout_time: '18:00',
                               address: other_address, user: other_user)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'bosque'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content '2 resultados encontrados'
    expect(page).to have_link 'Pousada Bosque'
    expect(page).to have_link 'Pousada Bosques Verdes'
  end

  it "and doesn't get inactive houses" do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'senhasecreta')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99004-100')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00', checkout_time: '18:00',
                                    address: address, user: user)
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosques Verdes',
                                corporate_name: 'Santa Bárbara Hotelaria LTDA',
                                registration_number: '02303221000152',
                                phone_number: '1130205000',
                                email: 'atendimento@pousadabosque',
                                checkin_time: '08:00', checkout_time: '18:00',
                                address: other_address, user: other_user,
                                status: :inactive)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'bosque'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content '1 resultado encontrado'
    expect(page).to have_link 'Pousada Bosque'
    expect(page).not_to have_link 'Pousada Bosques Verdes'
  end

  it 'and gets no result' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'senhasecreta')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99004-100')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Campos Verdes',
                               corporate_name: 'Santa Bárbara Hotelaria LTDA',
                               registration_number: '02303221000152',
                               phone_number: '1130205000',
                               email: 'atendimento@pousadabosque',
                               checkin_time: '08:00', checkout_time: '18:00',
                               address: other_address, user: other_user)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'sol'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Nenhum resultado encontrado'
  end
end
