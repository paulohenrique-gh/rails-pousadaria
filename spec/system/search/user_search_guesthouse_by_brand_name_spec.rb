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

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00', checkout_time: '18:00',
                                    address: address, user: user,
                                    status: :inactive)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'bosque'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Nenhum resultado encontrado'
    expect(page).to have_content 'Termo da pesquisa: "bosque"'
  end

  it 'and gets no result' do
    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'sol'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Nenhum resultado encontrado'
  end

  it 'and list is in alphabetical order' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')

    address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'São José',
                                  city: 'Pulomiranga', state: 'RN',
                                  postal_code: '99000-525')
    address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                  number: '450',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Pulomiranga', state: 'RN',
                                  postal_code: '99004-100')
    address_three = Address.create!(street_name: 'Rua Teresa Cristina',
                                    number: '55',
                                    neighbourhood: 'Santa Teresa',
                                    city: 'Teresina', state: 'PI',
                                    postal_code: '72655-100')

    guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                        corporate_name: 'Uno LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'American Inn',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        email: 'dualidade@dualidade.com',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Três Reis',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_three, user: user_three)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'santa helena'
    click_on 'Buscar'

    # Assert
    first_result = page.find('.search_result_list-item:nth-child(1)')
    second_result = page.find('.search_result_list-item:nth-child(2)')
    expect(page).to have_content '2 resultados encontrados'
    expect(first_result).to have_link 'American Inn'
    expect(second_result).to have_link 'Santa Helena'
    expect(page).not_to have_content 'Pousada Três Reis'
  end
end
