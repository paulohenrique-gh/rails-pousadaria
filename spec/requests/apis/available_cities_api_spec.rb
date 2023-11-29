require 'rails_helper'

describe 'Available cities API' do
  context 'GET /api/v1/cities' do
    it 'returns list of cities' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
      user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'Santa Helena',
                                    city: 'São Paulo', state: 'SP',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Fortaleza', state: 'CE',
                                    postal_code: '60004-100')
      address_three = Address.create!(street_name: 'Rua Teresa Cristina',
                                      number: '55',
                                      neighbourhood: 'Santa Teresa',
                                      city: 'Teresina', state: 'PI',
                                      postal_code: '72655-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Pousada Uno',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'Pousada Dualidade',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)
      guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Três Reis',
                                          corporate_name: 'Pousada Três Reis LTDA',
                                          registration_number: '0333033333',
                                          phone_number: '1130333333',
                                          email: 'tresreis@tresreis.com',
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_three, user: user_three)

      # Act
      get api_v1_cities_path

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq 3
      expect(json_response[0]["city_name"]).to eq 'Fortaleza'
      expect(json_response[1]["city_name"]).to eq 'São Paulo'
      expect(json_response[2]["city_name"]).to eq 'Teresina'
    end

    it 'returns empty if there are no guesthouses' do
      get api_v1_cities_path

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end

    it 'raise internal error' do
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

      allow(Address).to receive(:available_cities).and_raise(ActiveRecord::ActiveRecordError)

      # Act
      get api_v1_cities_path

      # Assert
      expect(response).to have_http_status(500)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Erro interno'
    end
  end
end
