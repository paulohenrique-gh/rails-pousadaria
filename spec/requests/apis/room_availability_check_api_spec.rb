require 'rails_helper'

describe 'Room availability check API' do
  context 'GET api/v1/rooms/:room_id/check_availability' do
    it 'returns stay total when room is available' do
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

      room = Room.create!(name: 'México',
                          description: 'Quarto com tema México',
                          dimension: 150, max_people: 2, daily_rate: 120,
                          private_bathroom: true, accessibility: true,
                          guesthouse: guesthouse)

      # Act
      checkin = 10.days.from_now.to_date.strftime('%Y-%m-%d')
      checkout = 20.days.from_now.to_date.strftime('%Y-%m-%d')
      get(
        "/api/v1/rooms/#{room.id}/check_availability/?checkin=#{checkin}&checkout=#{checkout}&guest_count=2"
      )

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["stay_total"]).to eq 1320
    end

    it 'returns error message when host sets the room as unavailable' do
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

      room = Room.create!(name: 'México',
                          description: 'Quarto com tema México',
                          dimension: 150, max_people: 2, daily_rate: 120,
                          private_bathroom: true, accessibility: true,
                          guesthouse: guesthouse, available: false)

      # Act
      checkin = 10.days.from_now.to_date.strftime('%Y-%m-%d')
      checkout = 20.days.from_now.to_date.strftime('%Y-%m-%d')
      get(
        "/api/v1/rooms/#{room.id}/check_availability/?" +
        "checkin=#{checkin}&checkout=#{checkout}&guest_count=2"
      )

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Quarto não disponível no período informado'
    end

    it 'returns error message when room is booked' do
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

      room = Room.create!(name: 'México',
                          description: 'Quarto com tema México',
                          dimension: 150, max_people: 2, daily_rate: 120,
                          private_bathroom: true, accessibility: true,
                          guesthouse: guesthouse)

      room.reservations.create!(guest_count: 2, checkin: 12.days.from_now,
                                checkout: 20.days.from_now, stay_total: 1080,
                                guest: guest)

      # Act
      checkin = 10.days.from_now.to_date.strftime('%Y-%m-%d')
      checkout = 20.days.from_now.to_date.strftime('%Y-%m-%d')
      get(
        "/api/v1/rooms/#{room.id}/check_availability/?" +
        "checkin=#{checkin}&checkout=#{checkout}&guest_count=2"
      )

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Quarto não disponível no período informado'
    end

    it 'fails with invalid parameters' do
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

      room = Room.create!(name: 'México',
                          description: 'Quarto com tema México',
                          dimension: 150, max_people: 2, daily_rate: 120,
                          private_bathroom: true, accessibility: true,
                          guesthouse: guesthouse)

      # Act
      get(
        "/api/v1/rooms/#{room.id}/check_availability/?checkin=bad request&checkout=2023/12/05"
      )

      # Assert
      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Parâmetros inválidos'
    end

    it 'fails when checkin date given is in the past' do
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

      room = Room.create!(name: 'México',
                          description: 'Quarto com tema México',
                          dimension: 150, max_people: 2, daily_rate: 120,
                          private_bathroom: true, accessibility: true,
                          guesthouse: guesthouse)

      # Act
      checkin = 5.days.ago.to_date.strftime('%Y-%m-%d')
      checkout = 20.days.from_now.to_date.strftime('%Y-%m-%d')
      get(
        "/api/v1/rooms/#{room.id}/check_availability/?checkin=#{checkin}&checkout=#{checkout}&guest_count=2"
      )

      # Assert
      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Parâmetros inválidos'
    end
  end
end
