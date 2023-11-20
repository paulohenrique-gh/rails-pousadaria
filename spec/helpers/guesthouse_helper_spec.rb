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
      result = pet_policy_description(guesthouse.pet_policy)

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
      result = pet_policy_description(guesthouse.pet_policy)

      # Assert
      expect(result).to eq 'Não aceita pets'
    end
  end

  describe '#formatted_time' do
    it 'returns the string in the correct format' do
      # Arrange
      time = Time.parse('2023-11-11 21:31:31.004964801 -0300')

      # Act
      result = formatted_time(time)

      # Assert
      expect(result).to eq '21:31'
    end

    it 'raises error when type is invalid' do
      # Arrange
      time = 'wrong format'

      # Act
      result = formatted_time(time)

      # Assert
      expect(result).to eq '00:00'
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

  describe '#payment_methods_description' do
    it 'with 3 payment methods' do
      # Arrange
      guesthouse = Guesthouse.new(payment_method_one: 'Cartão',
                                  payment_method_two: 'Pix',
                                  payment_method_three: 'Dinheiro')

      # Act
      result = payment_methods_description(guesthouse)

      # Assert
      expect(result).to eq 'Cartão | Pix | Dinheiro'
    end

    it 'with 2 payment methods' do
      # Arrange
      guesthouse = Guesthouse.new(payment_method_one: 'Cartão',
                                  payment_method_two: 'Pix')

      # Act
      result = payment_methods_description(guesthouse)

      # Assert
      expect(result).to eq 'Cartão | Pix'
    end

    it 'with 1 payment method' do
      # Arrange
      guesthouse = Guesthouse.new(payment_method_one: 'Cartão')

      # Act
      result = payment_methods_description(guesthouse)

      # Assert
      expect(result).to eq 'Cartão'
    end
  end
end
