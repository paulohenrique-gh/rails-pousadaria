require 'rails_helper'

describe 'User visits home page' do
  it 'and sees available cities in alphabetical order' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')


    address_one = Address.create!(street_name: 'Rua Carlos Pontes',
                                  number: '450',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Casarão', state: 'RN',
                                  postal_code: '99004-100')
    address_two = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Bananeira', state: 'RN',
                                  postal_code: '99000-525')
    address_three = Address.create!(street_name: 'Rua Teresa Cristina',
                                    number: '55',
                                    neighbourhood: 'Santa Teresa',
                                    city: 'Americana', state: 'PI',
                                    postal_code: '72655-100')

    guesthouse_one = Guesthouse.create!(brand_name: 'Pousada Dualidade',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'Pousada Uno',
                                        corporate_name: 'Uno LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Três Reis',
                                        corporate_name: 'Pousada Três Reis LTDA',
                                        registration_number: '0333033333',
                                        phone_number: '1130333333',
                                        email: 'tresreis@tresreis.com',
                                        address: address_three, user: user_three)

    # Act
    visit root_path
    # debugger

    # Assert
    first_item = page.find('.cities_list-city_link:nth-child(1)')
    second_item = page.find('.cities_list-city_link:nth-child(2)')
    third_item = page.find('.cities_list-city_link:nth-child(3)')
    expect(first_item).to have_link 'Americana'
    expect(second_item).to have_link 'Bananeira'
    expect(third_item).to have_link 'Casarão'
  end
end
