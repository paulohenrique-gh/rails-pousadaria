require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe '#calculate_stay_total' do
  context 'after guesthouse standard checkout' do
    it 'adds 1 day to total' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                            email: 'pedrada@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205000',
                                      email: 'atendimento@pousadabosque',
                                      checkin_time: '10:00',
                                      checkout_time: '14:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil',
                          description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.day.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, room: room, guest: guest,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.day.from_now)

      # Act
      travel_to 9.days.from_now.change(hour: 15) do
        result = reservation.reprocess_stay_total
        # Assert
        expect(result).to eq room.daily_rate * 10
      end
    end
  end

  context 'before guesthouse standard checkout' do
    it 'only considers up to the checkout date' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                            email: 'pedrada@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205000',
                                      email: 'atendimento@pousadabosque',
                                      checkin_time: '10:00',
                                      checkout_time: '14:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil',
                          description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.day.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, room: room, guest: guest,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.day.from_now)

      # Act
      travel_to 9.days.from_now.change(hour: 13) do
        result = reservation.reprocess_stay_total
        # Assert
        expect(result).to eq room.daily_rate * 9
      end
    end
  end

  context 'with status other than guests_checked_in' do
    it 'raises error' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                            email: 'pedrada@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205000',
                                      email: 'atendimento@pousadabosque',
                                      checkin_time: '10:00',
                                      checkout_time: '14:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil',
                          description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.day.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, room: room, guest: guest,
                                        status: :confirmed)

      # Act
      travel_to 9.days.from_now.change(hour: 13) do
        # Assert
        expect { reservation.reprocess_stay_total }.to raise_error(RuntimeError,
                                             'Reserva sem check-in registrado')
      end
    end
  end
end
