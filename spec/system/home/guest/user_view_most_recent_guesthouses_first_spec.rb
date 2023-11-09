require 'rails_helper'

describe 'User visits home page' do
  it 'and sees the three most recent guesthouses first' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')
    user_four = User.create!(email: 'usuario4@mail.com', password: 'password4')
    user_five = User.create!(email: 'usuario5@mail.com', password: 'password5')

    address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Pulomiranga', state: 'RN',
                                  postal_code: '99000-525')
    address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                  number: '450',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Natal', state: 'RN',
                                  postal_code: '99004-100')
    address_three = Address.create!(street_name: 'Rua Teresa Cristina',
                                    number: '55',
                                    neighbourhood: 'Santa Teresa',
                                    city: 'Teresina', state: 'PI',
                                    postal_code: '72655-100')
    address_four = Address.create!(street_name: 'Rua Quadrada',
                                    number: '22',
                                    neighbourhood: 'Quadrangular',
                                    city: 'Quadradópolis', state: 'DF',
                                    postal_code: '44444-444')
    address_five = Address.create!(street_name: 'Rua das Quintas',
                                    number: '555',
                                    neighbourhood: 'Quintanda',
                                    city: 'Cinco Santos', state: 'PR',
                                    postal_code: '55555-555')

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
    guesthouse_four = Guesthouse.create!(brand_name: 'Pousada Quaresma',
                                        corporate_name: 'Quaresma LTDA',
                                        registration_number: '00114444444',
                                        phone_number: '1130444444',
                                        email: 'quaresma@quaresma.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_four, user: user_four)
    guesthouse_five = Guesthouse.create!(brand_name: 'Pousada Cinco Estrelas',
                                        corporate_name: 'Cinco Estrelas LTDA',
                                        registration_number: '00555500555',
                                        phone_number: '1130555555',
                                        email: 'cinco@estrelas.com',
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_five, user: user_five)

    # Act
    visit root_path

    # Assert
    within('.recent_guesthouses') do
      expect(page).to have_content "Pousada Cinco Estrelas\nCinco Santos"
      expect(page).to have_content "Pousada Quaresma\nQuadradópolis"
      expect(page).to have_content "Pousada Três Reis\nTeresina"
      expect(page).not_to have_content "Pousada Dualidade\nNatal"
      expect(page).not_to have_content "Pousada Uno\nPulomiranga"
    end
  end
end
