require 'rails_helper'

RSpec.describe Purchase, type: :model do
  context '#valid?' do
    it 'returns false with empty product_name' do
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.days.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, guest: guest, room: room,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.days.from_now.to_datetime)

      purchase = Purchase.new(product_name: '', price: 5, quantity: 2,
                              reservation: reservation)

      # Assert
      expect(purchase).not_to be_valid
    end

    it 'returns false with empty price' do
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.days.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, guest: guest, room: room,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.days.from_now.to_datetime)

      purchase = Purchase.new(product_name: 'Pastel', price: nil, quantity: 2,
                              reservation: reservation)

      # Assert
      expect(purchase).not_to be_valid
    end

    it 'returns false with empty quantity' do
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.days.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, guest: guest, room: room,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.days.from_now.to_datetime)

      purchase = Purchase.new(product_name: 'Pastel', price: 5, quantity: nil,
                              reservation: reservation)

      # Assert
      expect(purchase).not_to be_valid
    end

    it 'returns false with price bellow 0.01' do
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.days.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, guest: guest, room: room,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.days.from_now.to_datetime)

      purchase = Purchase.new(product_name: 'Pastel', price: -5, quantity: 2,
                              reservation: reservation)

      # Assert
      expect(purchase).not_to be_valid
    end

    it 'returns false with quantity bellow 1' do
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

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 1.days.from_now,
                                        checkout: 10.days.from_now, guest_count: 2,
                                        stay_total: 1500, guest: guest, room: room,
                                        status: :guests_checked_in,
                                        checked_in_at: 1.days.from_now.to_datetime)

      purchase = Purchase.new(product_name: 'Pastel', price: 5, quantity: 0,
                              reservation: reservation)

      # Assert
      expect(purchase).not_to be_valid
    end
  end
end
