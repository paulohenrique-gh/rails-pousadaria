require 'rails_helper'

describe 'Room listing API' do
  context 'GET /api/v1/guesthouses/:guesthouse_id/rooms' do
    it 'returns a list with guesthouse rooms' do
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

      guesthouse.rooms.create!(name: 'México',
                               description: 'Quarto com tema México',
                               dimension: 150, max_people: 2, daily_rate: 120,
                               private_bathroom: true, accessibility: true)
      guesthouse.rooms.create!(name: 'EUA',
                               description: 'Quarto com tema EUA',
                               dimension: 400, max_people: 5, daily_rate: 400,
                               tv: true, balcony: true)

      # Act
      get api_v1_guesthouse_rooms_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.size).to eq 2
      expect(json_response.first["name"]).to eq 'México'
      expect(json_response.first["description"]).to eq 'Quarto com tema México'
      expect(json_response.first["dimension"]).to eq 150
      expect(json_response.first["max_people"]).to eq 2
      expect(json_response.first["daily_rate"]).to eq 120
      expect(json_response.first["private_bathroom"]).to eq true
      expect(json_response.first["balcony"]).to eq false
      expect(json_response.first["air_conditioning"]).to eq false
      expect(json_response.first["tv"]).to eq false
      expect(json_response.first["closet"]).to eq false
      expect(json_response.first["accessibility"]).to eq true
      expect(json_response.first["available"]).to eq true
      expect(json_response.first["closet"]).to eq false
      expect(json_response.first.keys).not_to include("created_at")
      expect(json_response.first.keys).not_to include("updated_at")

      expect(json_response.second["name"]).to eq 'EUA'
      expect(json_response.second["description"]).to eq 'Quarto com tema EUA'
      expect(json_response.second["dimension"]).to eq 400
      expect(json_response.second["max_people"]).to eq 5
      expect(json_response.second["daily_rate"]).to eq 400
      expect(json_response.second["private_bathroom"]).to eq false
      expect(json_response.second["balcony"]).to eq true
      expect(json_response.second["air_conditioning"]).to eq false
      expect(json_response.second["tv"]).to eq true
      expect(json_response.second["closet"]).to eq false
      expect(json_response.second["accessibility"]).to eq false
      expect(json_response.second["available"]).to eq true
      expect(json_response.second["closet"]).to eq false
      expect(json_response.second.keys).not_to include("created_at")
      expect(json_response.second.keys).not_to include("updated_at")
    end

    it 'returns an empty list when there are no rooms' do
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

      # Act
      get api_v1_guesthouse_rooms_path(guesthouse.id)

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end

    it 'raises internal error' do
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

        allow(Guesthouse).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

        # Act
        get api_v1_guesthouse_rooms_path(guesthouse.id)

        # Assert
        expect(response).to have_http_status(500)
    end

    it 'fails if guesthouse is not found' do
      get api_v1_guesthouse_rooms_path(99999999999999)

      expect(response).to have_http_status(404)
    end
  end
end
