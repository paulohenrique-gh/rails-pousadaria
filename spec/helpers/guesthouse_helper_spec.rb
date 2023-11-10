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
                        pet_policy: true, checkin_time: '08:00',
                        checkout_time: '18:00',
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
                        pet_policy: false, checkin_time: '08:00',
                        checkout_time: '18:00',
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
                        checkin_time: '08:30', checkout_time: '18:00',
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
                        checkin_time: '08:00', checkout_time: '20:30',
                        address: address, user: user)

      # Act
      result = formatted_checkout_time(guesthouse)

      # Assert
      expect(result).to eq '20:30'
    end
  end

  describe '#search_result_message' do
    it 'returns the correct string when input size is 1' do
      # Arrange
      collection = ['item 1']

      # Act
      result = search_result_message(collection)

      # Assert
      expect(result).to eq '1 resultado encontrado'
    end

    it 'returns the correct string when input size is greater than 1' do
      # Arrange
      collection = ['item 1', 'item 2', 'item 3']

      # Act
      result = search_result_message(collection)

      # Assert
      expect(result).to eq '3 resultados encontrados'
    end
  end

  describe '#formatted_search_param' do
    it 'returns the correct string with string fields' do
      # Act
      result = formatted_search_param("brand_name", "Pousada Max")

      # Assert
      expect(result).to eq 'Nome fantasia: "Pousada Max"'
    end

    it 'returns the correct string with boolean fields' do
      # Act
      result = formatted_search_param("tv", "1")

      # Assert
      expect(result).to eq 'Possui TV'
    end
  end
end
