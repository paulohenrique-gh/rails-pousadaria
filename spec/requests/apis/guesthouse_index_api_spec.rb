require 'rails_helper'

describe 'GET /api/v1/guesthouses' do
  context 'with no parameters' do
    it 'lists all guesthouses ordered by brand_name' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'São João',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      get api_v1_guesthouses_path

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response.first["brand_name"]).to eq 'Santa Helena'
      expect(json_response.first["phone_number"]).to eq '1131111111'
      expect(json_response.first["email"]).to eq 'uno@uno.com'
      expect(json_response.first["pet_policy"]).to eq true
      expect(json_response.first["checkin_time"]).to eq '08:00'
      expect(json_response.first["checkout_time"]).to eq '18:00'
      expect(json_response.first["address"]["street_name"]).to eq 'Rua das Pedras'
      expect(json_response.first["address"]["number"]).to eq '30'
      expect(json_response.first["address"]["neighbourhood"]).to eq 'São José'
      expect(json_response.first["address"]["city"]).to eq 'Pulomiranga'
      expect(json_response.first["address"]["state"]).to eq 'RN'
      expect(json_response.first["address"]["postal_code"]).to eq '99000-525'

      expect(json_response.second["brand_name"]).to eq 'São João'
      expect(json_response.second["phone_number"]).to eq '1132222222'
      expect(json_response.second["email"]).to eq 'dualidade@dualidade.com'
      expect(json_response.second["pet_policy"]).to eq true
      expect(json_response.second["checkin_time"]).to eq '08:00'
      expect(json_response.second["checkout_time"]).to eq '18:00'
      expect(json_response.second["address"]["street_name"]).to eq 'Rua Carlos Pontes'
      expect(json_response.second["address"]["number"]).to eq '450'
      expect(json_response.second["address"]["neighbourhood"]).to eq 'Santa Helena'
      expect(json_response.second["address"]["city"]).to eq 'Natal'
      expect(json_response.second["address"]["state"]).to eq 'RN'
      expect(json_response.second["address"]["postal_code"]).to eq '99004-100'
    end

    it 'returns an empty array when there are no guesthouses' do
      get api_v1_guesthouses_path

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end

    it 'raises error' do
      # Arrange
      allow(Guesthouse).to receive(:active).and_raise(ActiveRecord::QueryCanceled)

      # Act
      get api_v1_guesthouses_path

      # Assert
      expect(response).to have_http_status(500)
    end
  end

  context 'with parameters' do
    it 'returns the correct guesthouse' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'São Pedro',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      get '/api/v1/guesthouses/?search=santa helena'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.size).to eq 1
      expect(json_response.first["brand_name"]).to eq 'Santa Helena'
    end

    it 'returns an empty array if there are no matches' do
      # Arrange
      user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
      user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')

      address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                    neighbourhood: 'São José',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99000-525')
      address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')

      guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                          corporate_name: 'Uno LTDA',
                                          registration_number: '000000000001',
                                          phone_number: '1131111111',
                                          email: 'uno@uno.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_one, user: user_one)
      guesthouse_two = Guesthouse.create!(brand_name: 'São Pedro',
                                          corporate_name: 'Dualidade LTDA',
                                          registration_number: '0202020202',
                                          phone_number: '1132222222',
                                          email: 'dualidade@dualidade.com',
                                          pet_policy: true,
                                          checkin_time: '08:00',
                                          checkout_time: '18:00',
                                          address: address_two, user: user_two)

      # Act
      get '/api/v1/guesthouses/?search=pousada repouso'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end
  end
end
