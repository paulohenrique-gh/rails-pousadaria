require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '.quick_search' do
    it 'gives correct result using brand_name' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Heloísa',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Heloísa Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      result = Guesthouse.quick_search('helena')

      # Assert
      expect(result).to eq [guesthouse_one]
    end

    it 'gives correct result using neighbourhood name' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Heloísa',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Heloísa Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      result = Guesthouse.quick_search('santa heloísa')

      # Assert
      expect(result).to eq [guesthouse_two]
    end

    it 'gives correct result using city name' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Heloísa',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Heloísa Inn',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      result = Guesthouse.quick_search('natal')

      # Assert
      expect(result).to eq [guesthouse_two]
    end
  end

  it 'returns empty' do
    result = Guesthouse.quick_search('respouso')

    expect(result).to eq []
  end
end
