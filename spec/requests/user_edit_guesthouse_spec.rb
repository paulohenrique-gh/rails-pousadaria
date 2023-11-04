require 'rails_helper'

describe 'User edits guesthouse' do
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
    patch(
      guesthouse_path(guesthouse.id),
      params: { guesthouse: { brand_name: 'Nova Pousada'}}
    )
    guesthouse.reload

    # Assert
    expect(guesthouse.brand_name).to eq 'Pousada Bosque'
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'and must be the owner' do
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
    login_as other_user
    patch(
      guesthouse_path(guesthouse.id),
      params: { guesthouse: { brand_name: 'Nova Pousada'}}
    )
    guesthouse.reload

    # Assert
    expect(guesthouse.brand_name).to eq 'Pousada Bosque'
    expect(response).to redirect_to(root_path)
  end

  it 'and guesthouse must be active' do
    # Assert
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
    patch(
      guesthouse_path(guesthouse.id),
      params: { guesthouse: { brand_name: 'Nova Pousada'}}
    )
    guesthouse.reload

    # Assert
    expect(guesthouse.brand_name).not_to eq 'Nova Pousada'
    expect(response).to redirect_to(root_path)
  end
end
