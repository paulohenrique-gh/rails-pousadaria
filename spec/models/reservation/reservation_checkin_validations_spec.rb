require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe Reservation, type: :model do
  describe '#guests_checked_in!' do
    it 'before scheduled checkin date' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 5.days.from_now,
                                        checkout: 10.days.from_now,
                                        guest_count: 2, room: room,
                                        stay_total: 900, guest: guest,
                                        status: :confirmed)

      # Act
      reservation.guests_checked_in!

      # Assert
      expect(reservation.reload.guests_checked_in?).to be false
    end

    it 'between checkin and checkout dates' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 5.days.from_now,
                                        checkout: 10.days.from_now,
                                        guest_count: 2, room: room,
                                        stay_total: 900, guest: guest,
                                        status: :confirmed)

      # Act
      travel_to 6.days.from_now do
        reservation.guests_checked_in!
      end

      # Assert
      expect(reservation.reload.guests_checked_in?).to be true
    end

    it 'with status other than confirmed' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 5.days.from_now,
                                        checkout: 10.days.from_now,
                                        guest_count: 2, room: room,
                                        stay_total: 900, guest: guest,
                                        status: :cancelled)

      # Act
      travel_to 6.days.from_now do
        reservation.guests_checked_in!
      end

      # Assert
      expect(reservation.reload.guests_checked_in?).to be false
    end

    it 'generates timestamp for checked_in_at' do
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
                                      checkin_time: '08:00',
                                      checkout_time: '18:00',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 5.days.from_now,
                                        checkout: 10.days.from_now,
                                        guest_count: 2, room: room,
                                        stay_total: 900, guest: guest,
                                        status: :confirmed)

      # Act
      travel_to 6.days.from_now do
        reservation.guests_checked_in!

        #Assert
        expect(reservation.checked_in_at).to eq DateTime.now
      end
    end
  end
end
