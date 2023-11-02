require 'rails_helper'

describe 'User visits home page' do
  it 'and sees link to their registered guesthouse' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    guesthouse = Guesthouse.create!(
      brand_name: 'Pousada Bosque',
      corporate_name: 'Pousada Ramos Faria LTDA',
      registration_number: '02303221000152',
      phone_number: '1130205000',
      email: 'atendimento@pousadabosque',
      address: address,
      user: user
    )

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_link 'Minha Pousada'
  end

  it 'and sees other guesthouses' do
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
                               phone_number: '1130205555',
                               email: 'atendimento@camposverdes.com',
                               address: other_address, user: other_user)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_link 'Pousada Campos Verdes'
    expect(page).to have_content 'Telefone: 1130205555'
    expect(page).to have_content 'E-mail: atendimento@camposverdes.com'
    expect(page).to have_content(
      'Rua Carlos Pontes, 450, Santa Helena, 99004-100, Pulomiranga - RN'
    )
  end
end
