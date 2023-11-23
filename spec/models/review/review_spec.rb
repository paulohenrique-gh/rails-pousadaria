require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#valid?' do
    it 'returns false when rating is empty' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')

      review = Review.new(rating: nil, description: 'Hospedagem boa',
                          reservation: reservation)

      # Assert
      expect(review).not_to be_valid
    end

    it 'returns false when description is empty' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')

      review = Review.new(rating: 4, description: '', reservation: reservation)

      # Assert
      expect(review).not_to be_valid
    end

    it 'returns true when response is empty before update' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')

      review = Review.new(rating: 4, description: 'Hospedagem legal',
                          reservation: reservation, response: '')

      # Assert
      expect(review).to be_valid
    end

    it 'returns false when response is empty before on update' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')

      review = Review.create!(rating: 4, description: 'Hospedagem legal',
                              reservation: reservation)

      review.response = ''

      # Assert
      expect(review.reload).not_to be_valid
    end

    it 'returns true with only rating and description before saving' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')

      review = Review.new(rating: 4, description: 'Hospedagem legal',
                          reservation: reservation)

      # Assert
      expect(review).to be_valid
    end
  end
end
