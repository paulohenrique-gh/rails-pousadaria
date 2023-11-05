require 'rails_helper'

describe 'User adds room to guesthouse' do
  it 'and is not authenticated' do
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

    # Act
    post(guesthouse_rooms_path(guesthouse.id))

    # Assert
    expect(response).to redirect_to(new_user_session_path)
  end


  it 'and is not the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'senhasecreta')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Pulomiranga', state: 'RN',
                                    postal_code: '99004-100')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    address: address, user: user)
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Campos Verdes',
                               corporate_name: 'Santa Bárbara Hotelaria LTDA',
                               registration_number: '02303221000152',
                               phone_number: '1130205000',
                               email: 'atendimento@pousadabosque',
                               address: other_address, user: other_user)

    # Act
    login_as user
    post(
      guesthouse_rooms_path(other_guesthouse.id),
      params: {
        room: {
          name: 'Brasil', description: 'Quarto com tema Brasil',
          dimension: 200, max_people: 3, daily_rate: 150,
          guesthouse_id: other_guesthouse.id
        }
      }
    )
    other_guesthouse.reload

    # Assert
    expect(response).to redirect_to root_path
    expect(other_guesthouse.rooms.size).to eq 0
  end

  it 'and guesthouse is inactive' do
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
                                    address: address, user: user,
                                    status: :inactive)

    # Act
    login_as user
    post(
      guesthouse_rooms_path(guesthouse.id),
      params: {
        room: {
          name: 'Brasil', description: 'Quarto com tema Brasil',
          dimension: 200, max_people: 3, daily_rate: 150
        }
      }
    )
    guesthouse.reload

    # Assert
    expect(response).to redirect_to root_path
    expect(guesthouse.rooms.size).to eq 0
  end
end
