require 'rails_helper'

RSpec.describe GuesthouseHelper, type: :helper do
  describe '#pet_policy_description' do
    it 'returns the correct policy string when true' do
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
                        pet_policy: true,
                        address: address, user: user)

      # Act
      result = pet_policy_description(guesthouse)

      # Assert
      expect(result).to eq 'Aceita pets'
    end

    it 'returns the correct policy string when false' do
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
                        pet_policy: false,
                        address: address, user: user)

      # Act
      result = pet_policy_description(guesthouse)

      # Assert
      expect(result).to eq 'Não aceita pets'
    end
  end

  describe '#formatted_checkin_time' do
    it 'returns the string in the correct format' do
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
                        checkin_time: '08:30',
                        address: address, user: user)

      # Act
      result = formatted_checkin_time(guesthouse)

      # Assert
      expect(result).to eq '08:30'
    end
  end

  describe '#formatted_checkout_time' do
    it 'returns the string in the correct format' do
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
                        checkout_time: '20:30',
                        address: address, user: user)

      # Act
      result = formatted_checkout_time(guesthouse)

      # Assert
      expect(result).to eq '20:30'
    end
  end
end