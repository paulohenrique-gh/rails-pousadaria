require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#valid?' do
    context 'finish date is greater than start date' do
      it 'returns false when finish date is less than start date' do
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

        room = Room.create!(name: 'Brasil ',
                            description: 'Quarto com tema Brasil',
                            dimension: 200, max_people: 3, daily_rate: 150,
                            guesthouse: guesthouse)

        seasonal_rate = SeasonalRate.new(start_date: '2024-01-01',
                                        finish_date: '2023-12-24',
                                        rate: 200, room: room)

        expect(seasonal_rate).not_to be_valid
        expect(seasonal_rate.errors.include? :finish_date).to be true
        expect(seasonal_rate.errors[:finish_date]).to include(
          'não pode ser menor que data inicial'
        )
      end

      it 'returns true when finish date is greater' do
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

        room = Room.create!(name: 'Brasil ',
                            description: 'Quarto com tema Brasil',
                            dimension: 200, max_people: 3, daily_rate: 150,
                            guesthouse: guesthouse)

        seasonal_rate = SeasonalRate.new(start_date: '2023-12-24',
                                        finish_date: '2024-01-01',
                                        rate: 200, room: room)

        expect(seasonal_rate).to be_valid
        expect(seasonal_rate.errors.include? :finish_date).to be false
      end
    end
  end
end
