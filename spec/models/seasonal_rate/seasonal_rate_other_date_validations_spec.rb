require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#valid?' do
    context 'finish date' do
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

        seasonal_rate = SeasonalRate.new(start_date: 5.days.from_now,
                                         finish_date: 3.days.from_now,
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

        seasonal_rate = SeasonalRate.new(start_date: 3.days.from_now,
                                        finish_date: 5.days.from_now,
                                        rate: 200, room: room)

        expect(seasonal_rate).to be_valid
        expect(seasonal_rate.errors.include? :finish_date).to be false
      end
    end

    context 'start date' do
      it 'returns false if date is in the past' do
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

        seasonal_rate = SeasonalRate.new(start_date: 2.days.ago,
                                        finish_date: 10.days.from_now,
                                        rate: 200, room: room)

        expect(seasonal_rate).not_to be_valid
        expect(seasonal_rate.errors.include? :start_date).to be true
      end

      it 'returns true if date is in the present or future' do
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

        seasonal_rate = SeasonalRate.new(start_date: 2.days.from_now,
                                        finish_date: 10.days.from_now,
                                        rate: 200, room: room)

        expect(seasonal_rate).to be_valid
      end
    end
  end
end
