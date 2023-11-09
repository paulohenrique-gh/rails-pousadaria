require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#valid?' do
    it 'returns false when start_date is missing' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.new(finish_date: '2023-11-14', rate: 200,
                                       room: room)

      # Act / Assert
      expect(seasonal_rate).not_to be_valid
    end

    it 'returns false when finish_date is missing' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.new(start_date: '2023-11-09', rate: 200,
                                       room: room )

      # Act / Assert
      expect(seasonal_rate).not_to be_valid
    end

    it 'returns false when rate is missing' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.new(start_date: '2023-11-09',
                                       finish_date: '2023-11-14', room: room)

      # Act / Assert
      expect(seasonal_rate).not_to be_valid
    end

    it 'returns false when room is missing' do
      # Arrange
      seasonal_rate = SeasonalRate.new(start_date: '2023-11-09',
                                       finish_date: '2023-11-14', rate: 200)

      # Act / Assert
      expect(seasonal_rate).not_to be_valid
    end

    it 'returns true when all attributes are present' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.new(start_date: '2023-11-09',
                                       finish_date: '2023-11-14',
                                       rate: 200, room: room)

      # Act / Assert
      expect(seasonal_rate).to be_valid
    end
  end
end
