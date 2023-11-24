require 'rails_helper'

describe 'Guesthouse details API' do
  context 'GET /api/v1/guesthouses/:guesthouse_id' do
    it 'returns the guesthouse according to the ID' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
                            email: 'pedrada@mail.com', password: 'password')
      other_guest = Guest.create!(name: 'Manco Mancada', document: '10987654321',
                                  email: 'mancada@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                complement: 'Térreo',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')
      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
        corporate_name: 'Pousada Ramos Faria LTDA',
        registration_number: '02303221000152', phone_number: '1130205000',
        email: 'atendimento@pousadabosque',
        description: 'Pousada tranquila no interior do Rio Grande do Norte',
        payment_method_one: 'Pix', payment_method_two: 'Cartão de crédito',
        payment_method_three: 'Dinheiro', pet_policy: true,
        guesthouse_policy: 'Não é permitido uso de bebida alcoólica',
        checkin_time: '08:00', checkout_time: '20:00',
        address: address, user: user
      )

      room = Room.create!(name: 'Brasil',
                          description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          private_bathroom: true, balcony: true,
                          air_conditioning: true, tv: true, closet: true,
                          safe: true, accessibility: true, guesthouse: guesthouse)

      reservation = Reservation.create!(checkin: 2.days.from_now,
                                        checkout: 4.days.from_now,
                                        guest_count: 1, stay_total: 450,
                                        room: room, guest: guest,
                                        status: :guests_checked_out,
                                        checked_in_at: 2.days.from_now,
                                        checked_out_at: 4.days.from_now,
                                        payment_method: 'Dinheiro')
      reservation_two = Reservation.create!(checkin: 5.days.from_now,
                                            checkout: 10.days.from_now,
                                            guest_count: 2, stay_total: 900,
                                            room: room, guest: other_guest,
                                            status: :guests_checked_out,
                                            checked_in_at: 6.days.from_now,
                                            checked_out_at: 10.days.from_now,
                                            payment_method: 'Dinheiro')
      reservation_three = Reservation.create!(checkin: 11.days.from_now,
                                              checkout: 15.days.from_now,
                                              guest_count: 2, stay_total: 750,
                                              room: room, guest: other_guest,
                                              status: :guests_checked_out,
                                              checked_in_at: 11.days.from_now,
                                              checked_out_at: 14.days.from_now,
                                              payment_method: 'Dinheiro')
      reservation_four = Reservation.create!(checkin: 17.days.from_now,
                                            checkout: 20.days.from_now,
                                            guest_count: 2, stay_total: 600,
                                            room: room, guest: guest,
                                            status: :guests_checked_out,
                                            checked_in_at: 17.days.from_now,
                                            checked_out_at: 20.days.from_now,
                                            payment_method: 'Dinheiro')

      review = Review.create!(rating: 4, description: 'Muito bom',
                              reservation: reservation)
      review_two = Review.create!(rating: 5, description: 'Bem tranquilo',
                                    reservation: reservation_two)
      review_three = Review.create!(rating: 4, description: 'Bacana',
      reservation: reservation_three)
      review_four = Review.create!(rating: 2, description: 'Muito quente',
      reservation: reservation_four)

      # Act
      get api_v1_guesthouse_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["brand_name"]).to eq 'Pousada Bosque'
      expect(json_response["phone_number"]).to eq '1130205000'
      expect(json_response["email"]).to eq 'atendimento@pousadabosque'
      expect(json_response["description"]).to eq(
        'Pousada tranquila no interior do Rio Grande do Norte'
      )
      expect(json_response["payment_method_one"]).to eq 'Pix'
      expect(json_response["payment_method_two"]).to eq 'Cartão de crédito'
      expect(json_response["payment_method_three"]).to eq 'Dinheiro'
      expect(json_response["pet_policy"]).to eq true
      expect(json_response["guesthouse_policy"]).to eq(
        'Não é permitido uso de bebida alcoólica'
      )
      expect(json_response["checkin_time"]).to eq '08:00'
      expect(json_response["checkout_time"]).to eq '20:00'
      expect(json_response["average_rating"]).to eq 3.75
      expect(json_response["address"]["street_name"]).to eq 'Rua das Pedras'
      expect(json_response["address"]["number"]).to eq '30'
      expect(json_response["address"]["complement"]).to eq 'Térreo'
      expect(json_response["address"]["neighbourhood"]).to eq 'Santa Helena'
      expect(json_response["address"]["city"]).to eq 'Pulomiranga'
      expect(json_response["address"]["state"]).to eq 'RN'
      expect(json_response["address"]["postal_code"]).to eq '99000-525'
    end

    it 'returns average_rating as an empty string' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      other_user = User.create!(email: 'outroexemplo@mail.com', password: 'password')

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

      # Act
      get api_v1_guesthouse_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["average_rating"]).to eq ''
    end

    it 'returns 404 when guesthouse is inactive' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      other_user = User.create!(email: 'outroexemplo@mail.com', password: 'password')

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
                                      address: address, user: user,
                                      status: :inactive)

      # Act
      get api_v1_guesthouse_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(404)
    end

    it 'returns 404 when guesthouse is not found' do
      get api_v1_guesthouse_path(999999999)

      expect(response).to have_http_status(404)
    end

    it 'fails when an error occurs' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      other_user = User.create!(email: 'outroexemplo@mail.com', password: 'password')

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
                                      address: address, user: user,
                                      status: :inactive)

      allow(Guesthouse).to receive(:find).and_raise(ActiveRecord::QueryCanceled)

      # Act
      get api_v1_guesthouse_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(500)
    end
  end
end
