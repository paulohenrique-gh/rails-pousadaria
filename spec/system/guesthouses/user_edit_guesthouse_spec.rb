require 'rails_helper'

describe 'User edits guesthouse' do
  it 'and is not the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com', password: 'senhasecreta')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque', corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152', phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque')
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Campos Verdes',
                                          corporate_name: 'Santa Bárbara Hotelaria LTDA',
                                          registration_number: '02303221000152', phone_number: '1130205000',
                                          email: 'atendimento@pousadabosque')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99000-525',guesthouse: guesthouse)
    other_address = Address.create!(street_name: 'Rua Carlos Pontes', number: '450', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99004-100',guesthouse: other_guesthouse)

    # Act

  end
end
