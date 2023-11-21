require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#booked?' do
    context 'returns false when there is overlap in existing reservations' do
      it 'with new checkin between existing checkins or checkouts' do
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

        reservation = Reservation.create!(checkin: 10.days.from_now,
                                          checkout: 15.days.from_now,
                                          guest_count: 3, stay_total: 900,
                                          room: room, guest: guest)

        new_checkin = 15.days.from_now.to_date
        new_checkout = 20.days.from_now.to_date

        # Act
        result = room.booked?(new_checkin, new_checkout)

        # Assert
        expect(result).to be true
      end

      it 'with existing checkins and checkouts between new ones' do
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

        reservation = Reservation.create!(checkin: 10.days.from_now,
                                          checkout: 15.days.from_now,
                                          guest_count: 3, stay_total: 900,
                                          room: room, guest: guest)

        new_checkin = 8.days.from_now.to_date
        new_checkout = 20.days.from_now.to_date

        # Act
        result = room.booked?(new_checkin, new_checkout)

        # Assert
        expect(result).to be true
      end
    end

    it 'returns true with no overlap in existing reservations' do
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

      reservation = Reservation.create!(checkin: 10.days.from_now,
                                        checkout: 15.days.from_now,
                                        guest_count: 3, stay_total: 900,
                                        room: room, guest: guest)

      new_checkin = 16.days.from_now
      new_checkout = 30.days.from_now

      # Act
      result = room.booked?(new_checkin, new_checkout)

      # Assert
      expect(result).to be false
    end
  end
end
