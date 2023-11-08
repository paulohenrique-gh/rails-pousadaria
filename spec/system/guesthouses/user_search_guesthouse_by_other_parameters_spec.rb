require 'rails_helper'

describe 'User searches for a guesthouse' do
  it 'by neighbourhood' do
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
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'American Inn',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Três Reis',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        address: address_three, user: user_three)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'santa helena'
    click_on 'Buscar'

    # Assert
    first_result = page.find('.search_result_list-item:nth-child(1)')
    second_result = page.find('.search_result_list-item:nth-child(2)')
    expect(page).to have_content '2 resultados encontrados para "santa helena"'
    expect(first_result).to have_link 'American Inn'
    expect(second_result).to have_link 'Santa Helena'
    expect(page).not_to have_content 'Pousada Três Reis'
  end

  it 'by city' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')
    user_four = User.create!(email: 'usuario4@mail.com', password: 'password4')

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
    address_four = Address.create!(street_name: 'Rua São Pedro',
                                   number: '900',
                                   neighbourhood: 'Teresina',
                                   city: 'Fortaleza', state: 'CE',
                                   postal_code: '72655-100')

    guesthouse_one = Guesthouse.create!(brand_name: 'Pousada Teresina',
                                        corporate_name: 'Pousada Teresina LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'American Inn',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Esperança',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        address: address_three, user: user_three)
    guesthouse_four = Guesthouse.create!(brand_name: 'Forte da Paz',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        address: address_four, user: user_four)

    # Act
    visit root_path
    fill_in 'Buscar pousada', with: 'teresina'
    click_on 'Buscar'

    # Assert
    first_result = page.find('.search_result_list-item:nth-child(1)')
    second_result = page.find('.search_result_list-item:nth-child(2)')
    third_result = page.find('.search_result_list-item:nth-child(3)')
    expect(page).to have_content '3 resultados encontrados para "teresina"'
    expect(first_result).to have_link 'Forte da Paz'
    expect(second_result).to have_link 'Pousada Esperança'
    expect(third_result).to have_link 'Pousada Teresina'
    expect(page).not_to have_content 'American Inn'
  end
end
