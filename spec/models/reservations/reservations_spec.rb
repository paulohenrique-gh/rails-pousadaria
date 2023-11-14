require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#valid?' do
    context 'checkin' do
      it 'is empty' do
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
                            private_bathroom: true, tv: true,
                            guesthouse: guesthouse)

        reservation = Reservation.new(checkin: '',
                                      checkout: 10.days.from_now,
                                      guest_count: 2, room: room, stay_total: 900)

        # Assert
        expect(reservation).not_to be_valid
      end
    end

    context 'checkout' do
      it 'is empty' do
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
                            private_bathroom: true, tv: true,
                            guesthouse: guesthouse)

        reservation = Reservation.new(checkin: 5.days.from_now,
                                      checkout: '',
                                      guest_count: 2, room: room, stay_total: 900)

        # Assert
        expect(reservation).not_to be_valid
      end
    end

    context 'guest_count' do
      it 'is nil' do
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
                            private_bathroom: true, tv: true,
                            guesthouse: guesthouse)

        reservation = Reservation.new(checkin: 5.days.from_now,
                                      checkout: 10.days.from_now,
                                      guest_count: nil, room: room, stay_total: 900)

        # Assert
        expect(reservation).not_to be_valid
      end
    end

    context 'stay_total' do
      it 'is nil' do
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
                            private_bathroom: true, tv: true,
                            guesthouse: guesthouse)

        reservation = Reservation.new(checkin: 5.days.from_now,
                                      checkout: 10.days.from_now,
                                      guest_count: 2, room: room, stay_total: nil)

        # Assert
        expect(reservation).not_to be_valid
      end
    end

    it 'all parameters present' do
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
                          private_bathroom: true, tv: true,
                          guesthouse: guesthouse)

      reservation = Reservation.new(checkin: 5.days.from_now,
                                    checkout: 10.days.from_now,
                                    guest_count: 2, room: room, stay_total: 900)

      # Assert
      expect(reservation).to be_valid
    end
  end
end
