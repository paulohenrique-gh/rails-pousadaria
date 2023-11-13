require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '#valid' do
    it 'returns false when phone number length is less than 10' do
      # Act
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.new(brand_name: 'Pousada Bosque',
                                  corporate_name: 'Pousada Ramos Faria LTDA',
                                  registration_number: '02303221000152',
                                  phone_number: '1130205',
                                  email: 'atendimento@pousadabosque',
                                  checkin_time: '08:00', checkout_time: '18:00',
                                  address: address, user: user)

      # Assert
      expect(guesthouse).not_to be_valid
    end

    it 'returns false when phone number length is greater than 11' do
      # Act
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.new(brand_name: 'Pousada Bosque',
                                  corporate_name: 'Pousada Ramos Faria LTDA',
                                  registration_number: '02303221000152',
                                  phone_number: '1130205566565',
                                  email: 'atendimento@pousadabosque',
                                  checkin_time: '08:00', checkout_time: '18:00',
                                  address: address, user: user)

      # Assert
      expect(guesthouse).not_to be_valid
    end

    it 'returns true when phone number length is between 10 and 11' do
      # Act
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.new(brand_name: 'Pousada Bosque',
                                  corporate_name: 'Pousada Ramos Faria LTDA',
                                  registration_number: '02303221000152',
                                  phone_number: '1130205566',
                                  email: 'atendimento@pousadabosque',
                                  checkin_time: '08:00', checkout_time: '18:00',
                                  address: address, user: user)

      # Assert
      expect(guesthouse).to be_valid
    end
  end
end
