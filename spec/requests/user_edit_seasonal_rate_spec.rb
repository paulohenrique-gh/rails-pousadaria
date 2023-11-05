require 'rails_helper'

describe 'User edits seasonal rate' do
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
      guesthouse_room_seasonal_rate_path(guesthouse.id, room.id,
                                         seasonal_rate.id),
      params: {
        seasonal_rate: {
          start_date: '2023-11-12'
        }
      }
    )
    seasonal_rate.reload

    # Assert
    expect(response).to redirect_to(new_user_session_path)
    expect(seasonal_rate.start_date).to eq ('2023-11-10'.to_date)
  end

  it 'and is not the owner' do
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
      guesthouse_room_seasonal_rate_path(guesthouse.id, room.id,
                                         seasonal_rate.id),
      params: {
        seasonal_rate: {
          start_date: '2023-11-12'
        }
      }
    )
    seasonal_rate.reload

    # Assert
    expect(response).to redirect_to(root_path)
    expect(seasonal_rate.start_date).to eq ('2023-11-10'.to_date)
  end
end
