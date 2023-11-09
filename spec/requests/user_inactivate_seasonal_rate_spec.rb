require 'rails_helper'

describe 'User inactivates seasonal rate' do
  it 'and must be authenticated' do
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: '2023-11-10',
                                         finish_date: '2023-11-15',
                                         rate: 400, room: room)

    # Act
    patch(
      inactivate_guesthouse_room_seasonal_rate_path(guesthouse.id, room.id,
                                                    seasonal_rate.id),
    )
    seasonal_rate.reload

    # Assert
    expect(response).to redirect_to(new_user_session_path)
    expect(seasonal_rate).to be_active
  end

  it 'and must be the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: '123456')

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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: '2023-11-10',
                                         finish_date: '2023-11-15',
                                         rate: 400, room: room)

    # Act
    login_as other_user
    patch(
      inactivate_guesthouse_room_seasonal_rate_path(guesthouse.id, room.id,
                                                    seasonal_rate.id),
    )
    seasonal_rate.reload

    # Assert
    expect(response).to redirect_to(root_path)
    expect(seasonal_rate).to be_active
  end
end
