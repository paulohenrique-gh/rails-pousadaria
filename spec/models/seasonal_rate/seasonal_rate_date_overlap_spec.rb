require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#valid?' do
    context 'dates do not overlap' do
      it 'returns false when dates overlap' do
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

        seasonal_rate = SeasonalRate.create!(start_date: 5.days.from_now,
                                             finish_date: 10.days.from_now,
                                             rate: 200, room: room)
        other_seasonal_rate = SeasonalRate.new(start_date: 7.days.from_now,
                                               finish_date: 9.days.from_now,
                                               rate: 400, room: room)

        # Assert
        expect(other_seasonal_rate).not_to be_valid
        expect(other_seasonal_rate.errors.include? :start_date).to be true
        expect(other_seasonal_rate.errors.include? :finish_date).to be true
        expect(other_seasonal_rate.errors[:start_date]).to include(
          'dentro de período já cadastrado'
        )
        expect(other_seasonal_rate.errors[:finish_date]).to include(
          'dentro de período já cadastrado'
        )
      end

      it 'returns true when dates do not overlap' do
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

        seasonal_rate = SeasonalRate.create!(start_date: 15.days.from_now,
                                            finish_date: 25.days.from_now,
                                            rate: 200, room: room)
        other_seasonal_rate = SeasonalRate.new(start_date: 5.days.from_now,
                                              finish_date: 10.days.from_now,
                                              rate: 400, room: room)

        # Assert
        expect(other_seasonal_rate).to be_valid
        expect(other_seasonal_rate.errors.include? :start_date).to be false
        expect(other_seasonal_rate.errors.include? :finish_date).to be false
      end
    end
  end
end
