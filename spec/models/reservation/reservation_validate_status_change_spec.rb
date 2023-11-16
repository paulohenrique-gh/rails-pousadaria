require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#cancel' do
    it 'more than 7 days before checkin' do
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
                                        checkout: 20.days.from_now, guest_count: 2,
                                        stay_total: 900, room: room, guest: guest)

      # Act
      reservation.cancel

      # Assert
      expect(reservation.reload).to be_inactive
    end

    it 'within 7 days before checkin' do
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
                                        checkout: 20.days.from_now, guest_count: 2,
                                        stay_total: 900, room: room, guest: guest)

      # Act
      reservation.cancel

      # Assert
      expect(reservation.reload).not_to be_inactive
    end
  end

  describe '#elligible_for_checkin?' do
    it 'between checkin and checkout dates' do
      # Arrange
      reservation = Reservation.new(checkin: 1.day.ago, checkout: 5.days.from_now)

      # Act
      result = reservation.elligible_for_checkin?

      # Assert
      expect(result).to be true
    end

    it 'before scheduled checkin date' do
      # Arrange
      reservation = Reservation.new(checkin: 2.day.from_now, checkout: 5.days.from_now)

      # Act
      result = reservation.elligible_for_checkin?

      # Assert
      expect(result).to be false
    end
  end
end
