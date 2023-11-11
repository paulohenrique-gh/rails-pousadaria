require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '.advanced_search' do
    it 'returns correctly with only guesthouse parameters' do
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
                                    city: 'Natal', state: 'RN',
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
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Helena Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          air_conditioning: true, guesthouse: guesthouse_one)
      room_two = Room.create!(name: 'EUA', description: 'Quarto com tema América',
                              dimension: 400, max_people: 5, daily_rate: 300,
                              air_conditioning: true, guesthouse: guesthouse_two)

      # Act
      guesthouse_params = { brand_name: 'helena' }
      address_params = {}
      room_params = {}
      result = Guesthouse.advanced_search(guesthouse_params,
                                          address_params,
                                          room_params)

      # Assert
      expect(result).to eq [guesthouse_two, guesthouse_one]
    end

    it 'returns correctly with only address parameters' do
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
                                    city: 'Natal', state: 'RN',
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
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Helena Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          air_conditioning: true, guesthouse: guesthouse_one)
      room_two = Room.create!(name: 'EUA', description: 'Quarto com tema América',
                              dimension: 400, max_people: 5, daily_rate: 300,
                              air_conditioning: true, guesthouse: guesthouse_two)

      # Act
      guesthouse_params = {}
      address_params = { neighbourhood: 'josé' }
      room_params = {}
      result = Guesthouse.advanced_search(guesthouse_params,
                                          address_params,
                                          room_params)

      # Assert
      expect(result).to eq [guesthouse_one]
    end

    it 'returns correctly with only room parameters' do
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
                                    city: 'Natal', state: 'RN',
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
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Helena Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          tv: false, air_conditioning: true,
                          guesthouse: guesthouse_one)
      room_two = Room.create!(name: 'EUA', description: 'Quarto com tema América',
                              dimension: 400, max_people: 5, daily_rate: 300,
                              tv: true, air_conditioning: true,
                              guesthouse: guesthouse_two)

      # Act
      guesthouse_params = {}
      address_params = {}
      room_params = { tv: true }
      result = Guesthouse.advanced_search(guesthouse_params,
                                          address_params,
                                          room_params)

      # Assert
      expect(result).to eq [guesthouse_two]
    end

    it 'returns guesthouse without rooms' do
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
                                    city: 'Natal', state: 'RN',
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
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Helena Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          air_conditioning: true, guesthouse: guesthouse_one)
      room_two = Room.create!(name: 'EUA', description: 'Quarto com tema América',
                              dimension: 400, max_people: 5, daily_rate: 300,
                              air_conditioning: true, guesthouse: guesthouse_two)

      # Act
      guesthouse_params = {}
      address_params = { city: 'teresina' }
      room_params = {}
      result = Guesthouse.advanced_search(guesthouse_params,
                                          address_params,
                                          room_params)

      # Assert
      expect(result).to eq [guesthouse_three]
    end
  end
end
