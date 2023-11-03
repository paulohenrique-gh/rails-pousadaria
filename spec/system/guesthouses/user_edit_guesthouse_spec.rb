require 'rails_helper'

describe 'User edits guesthouse' do
  pending 'and is not authenticated'

  it 'and is not the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com', password: 'senhasecreta')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99000-525')
    other_address = Address.create!(street_name: 'Rua Carlos Pontes', number: '450', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99004-100')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque', corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152', phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque', address: address, user: user)
    other_guesthouse = Guesthouse.create!(brand_name: 'Pousada Campos Verdes',
                                          corporate_name: 'Santa Bárbara Hotelaria LTDA',
                                          registration_number: '02303221000152', phone_number: '1130205000',
                                          email: 'atendimento@pousadabosque', address: other_address, user: other_user)

    # Act
    login_as user
    visit edit_guesthouse_path(other_guesthouse.id)

    # Assert
    expect(page).to have_content 'Você não tem autorização para alterar esta pousada'
    expect(current_path).to eq root_path
  end

  it 'sucessfully' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99000-525')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque', corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152', phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque', address: address, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Pousada dos Diamantes'
    fill_in 'Logradouro', with: 'Rua das Jóias'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Pousada atualizada com sucesso'
    expect(page).to have_content 'Pousada dos Diamantes'
    expect(page).to have_content 'Telefone: 1130205000'
    expect(page).to have_content 'E-mail: atendimento@pousadabosque'
    expect(page).to have_content 'Rua das Jóias, 30, Santa Helena, 99000-525, Pulomiranga - RN'
  end

  it 'and leaves mandatory fields blank' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30', neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN', postal_code: '99000-525')

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque', corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152', phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque', address: address, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar'
    fill_in 'CNPJ', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).not_to have_content 'Pousada atualizada com sucesso'
    expect(page).to have_content 'Não foi possível atualizar a pousada'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(guesthouse.registration_number).to eq '02303221000152'
    expect(guesthouse.address.city).to eq 'Pulomiranga'
  end
end
