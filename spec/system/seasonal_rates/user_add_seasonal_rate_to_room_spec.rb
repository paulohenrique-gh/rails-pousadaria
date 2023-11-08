require 'rails_helper'

describe 'User adds seasonal rate to room' do
  it 'from the room editing page' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within('.room_details_list') do
      click_on 'Mais detalhes'
    end

    click_on 'Adicionar preço por período'

    # Assert
    expect(page).to have_content 'Pousada Bosque - Quarto Brasil'
    expect(page).to have_content 'Adicionar preço por período'
    expect(page).to have_field 'Data inicial'
    expect(page).to have_field 'Data final'
    expect(page).to have_field 'Valor'
    expect(page).to have_button 'Enviar'
  end

  it 'successfully' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)
    room.seasonal_rates.create!(start_date: '2023-11-20',
                                finish_date: '2023-11-30', rate: 225)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within('.room_details_list') do
      click_on 'Mais detalhes'
    end

    click_on 'Adicionar preço por período'
    fill_in 'Data inicial', with: '24/12/2023'
    fill_in 'Data final', with: '01/01/2024'
    fill_in 'Valor', with: 250
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Preço por período cadastrado com sucesso'
    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Preços por período:'
    expect(page).to have_content 'Padrão: R$ 150,00'
    expect(page).to have_content 'De 20/11/2023 a 30/11/2023: R$ 225,00'
    expect(page).to have_content 'De 24/12/2023 a 01/01/2024: R$ 250,00'
  end

  it 'and start date is greater than finish date' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within('.room_details_list') do
      click_on 'Mais detalhes'
    end

    click_on 'Adicionar preço por período'
    fill_in 'Data inicial', with: '01/01/2024'
    fill_in 'Data final', with: '24/12/2023'
    fill_in 'Valor', with: 250
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível cadastrar preço por período'
    expect(page).to have_content 'Data final não pode ser menor que data inicial'
    expect(room.seasonal_rates).to be_empty
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within('.room_details_list') do
      click_on 'Mais detalhes'
    end

    click_on 'Adicionar preço por período'
    fill_in 'Data inicial', with: ''
    fill_in 'Data final', with: ''
    fill_in 'Valor', with: 200
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível cadastrar preço por período'
    expect(page).to have_content 'Data inicial não pode ficar em branco'
    expect(page).to have_content 'Data final não pode ficar em branco'
    expect(room.seasonal_rates).to be_empty
  end

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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    visit new_guesthouse_room_seasonal_rate_path(guesthouse.id, room.id)

    # Assert
    expect(current_path).to eq new_user_session_path
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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    login_as other_user
    visit new_guesthouse_room_seasonal_rate_path(guesthouse.id, room.id)

    # Assert
    expect(current_path).to eq new_guesthouse_path
    expect(page).to have_content(
      'Você não tem autorização para alterar esta pousada'
    )
  end
end
