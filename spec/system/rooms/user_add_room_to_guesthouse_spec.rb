require 'rails_helper'

describe 'User adds a room to their guesthouse' do
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
    visit new_guesthouse_room_path(guesthouse.id)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'from the guesthouse details page' do
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
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar quarto'

    # Assert
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Dimensão'
    expect(page).to have_field 'Quantidade máxima de pessoas'
    expect(page).to have_field 'Valor da diária'
    expect(page).to have_field 'Possui banheiro próprio'
    expect(page).to have_field 'Possui varanda'
    expect(page).to have_field 'Possui ar-condicionado'
    expect(page).to have_field 'Possui TV'
    expect(page).to have_field 'Possui guarda-roupas'
    expect(page).to have_field 'Possui cofre'
    expect(page).to have_field 'Acessível para pessoas com deficiência'
    expect(page).to have_button 'Enviar'
  end

  it 'sucessfully' do
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
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar quarto'
    fill_in 'Nome', with: 'Brasil'
    fill_in 'Descrição', with: 'Quarto com tema Brasil'
    fill_in 'Dimensão em m²', with: 200
    fill_in 'Quantidade máxima de pessoas', with: 3
    fill_in 'Valor da diária', with: 150
    check 'Possui banheiro próprio'
    check 'Possui varanda'
    check 'Possui ar-condicionado'
    check 'Possui TV'
    check 'Possui guarda-roupas'
    check 'Possui cofre'
    check 'Acessível para pessoas com deficiência'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq guesthouse_path(guesthouse.id)
    expect(page).to have_content 'Quarto cadastrado com sucesso'
    expect(page).to have_link 'Brasil'
  end

  it 'and leaves required fields empty' do
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
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Adicionar quarto'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Dimensão em m²', with: ''
    fill_in 'Quantidade máxima de pessoas', with: ''
    fill_in 'Valor da diária', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível adicionar quarto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Dimensão em m² não pode ficar em branco'
    expect(page).to have_content(
      'Quantidade máxima de pessoas não pode ficar em branco'
    )
    expect(page).to have_content 'Valor da diária não pode ficar em branco'
    expect(guesthouse.rooms.size).to eq 0
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
    visit root_path
    click_on 'Minha Pousada'

    # Assert
    expect(page).not_to have_link 'Adicionar quarto'
  end
end
