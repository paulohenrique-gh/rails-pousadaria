require 'rails_helper'

describe 'User visits home page' do
  it 'and sees the name of the app' do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Pousadaria'
  end

  it "and sees the search bar" do
    # Act
    visit root_path

    # Assert
    expect(page).to have_field 'Buscar pousada'
  end

  it 'and sees only active guesthouses' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'senhasecreta')
    inactive_user = User.create!(email: 'inativo@mail.com',
                                 password: 'password')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes',
                                    number: '450',
                                    neighbourhood: 'Santa Helena',
                                    city: 'Natal', state: 'RN',
                                    postal_code: '99004-100')
    inactive_address = Address.create!(street_name: 'Rua Inativa',
                                       number: '90',
                                       neighbourhood: 'Santa Inativa',
                                       city: 'Pulomiranga', state: 'RN',
                                       postal_code: '99555-122')

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
    inactive_guesthouse = Guesthouse.create!(brand_name: 'Pousada Inativa',
                               corporate_name: 'Inativa Hotelaria LTDA',
                               registration_number: '02088891000152',
                               phone_number: '1132227777',
                               email: 'atendimento@inativa.com',
                               address: inactive_address, user: inactive_user,
                               status: :inactive)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content "Pousada Bosque\nPulomiranga"
    expect(page).to have_content "Pousada Campos Verdes\nNatal"
    expect(page).not_to have_content "Pousada Inativa\nPulomiranga"
  end
end
