require 'rails_helper'

describe 'User register guesthouse' do
  it 'and must be authenticated' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    address_params = { street_name: 'Rua das Pedras', number: '30',
                      neighbourhood: 'Santa Helena', city: 'Pulomiranga',
                      state: 'RN', postal_code: '99000-525' }
    guesthouse_params = { brand_name: 'Pousada Bosque',
                          corporate_name: 'Pousada Ramos Faria LTDA',
                          registration_number: '02303221000152',
                          phone_number: '1130205000',
                          email: 'atendimento@pousadabosque',
                          checkin_time: '08:00', checkout_time: '18:00',
                          address_attributes: address_params }

    # Act
    post guesthouses_path(params: { guesthouse: guesthouse_params })

    # Assert
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'and already has a guesthouse' do
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

    address_params = { street_name: 'Rua das Colinas', number: '30',
                      neighbourhood: 'Santa Maria', city: 'Pulomiranga',
                      state: 'RN', postal_code: '99030-525' }
    guesthouse_params = { brand_name: 'Pousada Maria',
                          corporate_name: 'Pousada Ramos Faria LTDA',
                          registration_number: '02303221000152',
                          phone_number: '1130205555',
                          email: 'atendimento@pousadabosque',
                          checkin_time: '08:00', checkout_time: '18:00',
                          address_attributes: address_params }

    # Act
    login_as user
    post guesthouses_path(params: { guesthouse: guesthouse_params })

    # Assert
    expect(response).to redirect_to root_path
  end
end
