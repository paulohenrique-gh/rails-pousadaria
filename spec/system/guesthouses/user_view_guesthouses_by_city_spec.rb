require 'rails_helper'

describe "User visits the guesthouses-by-city page" do
  it 'and sees available guesthouses in that city' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')

    address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'Santa Helena',
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

    guesthouse_one = Guesthouse.create!(brand_name: 'Pousada Uno',
                                        corporate_name: 'Uno LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'Pousada Dualidade',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
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
    click_on 'Pulomiranga'

    # Assert
    expect(page).to have_link 'Pousada Uno'
    expect(page).to have_link 'Pousada Dualidade'
    expect(page).not_to have_link 'Pousada Três Reis'
  end

  it 'and guesthouses are sorted by brand name in alphabetical order' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')

    address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'Santa Helena',
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
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '72655-100')

    guesthouse_one = Guesthouse.create!(brand_name: 'Casa de Família',
                                        corporate_name: 'Uno LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'Brisa',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Americana',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_three, user: user_three)

    # Act
    visit root_path
    click_on 'Pulomiranga'

    # Assert
    first_guesthouse = page.find('.guesthouses_by_city-list-item:nth-child(1)')
    second_guesthouse = page.find('.guesthouses_by_city-list-item:nth-child(2)')
    third_guesthouse = page.find('.guesthouses_by_city-list-item:nth-child(3)')
    expect(first_guesthouse).to have_link 'Americana'
    expect(second_guesthouse).to have_link 'Brisa'
    expect(third_guesthouse).to have_link 'Casa de Família'
  end

  it 'and there is no guesthouse in the city' do
    # Act
    visit guesthouses_by_city_path('Curitiba')

    # Assert
    expect(current_path).to eq root_path
  end
end
