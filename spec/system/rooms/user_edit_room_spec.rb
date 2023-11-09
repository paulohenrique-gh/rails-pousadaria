require 'rails_helper'

describe 'User edits room' do
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
    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    visit edit_guesthouse_room_path(guesthouse.id, room.id)

    # Assert
    expect(current_path).to eq new_user_session_path
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

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                    corporate_name: 'Pousada Ramos Faria LTDA',
                                    registration_number: '02303221000152',
                                    phone_number: '1130205000',
                                    email: 'atendimento@pousadabosque',
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    # Act
    login_as other_user
    visit edit_guesthouse_room_path(guesthouse.id, room.id)

    # Assert
    expect(page).to have_content(
      'Você não tem autorização para alterar esta pousada'
    )
    expect(current_path).to eq new_guesthouse_path
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
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
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
    click_on 'Editar'

    # Assert
    expect(page).to have_content 'Editar Quarto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Dimensão'
    expect(page).to have_field 'Quantidade máxima de pessoas'
    expect(page).to have_field 'Valor da diária padrão'
    expect(page).to have_field 'Possui banheiro próprio'
    expect(page).to have_field 'Possui varanda'
    expect(page).to have_field 'Possui ar-condicionado'
    expect(page).to have_field 'Possui TV'
    expect(page).to have_field 'Possui guarda-roupas'
    expect(page).to have_field 'Possui cofre'
    expect(page).to have_field 'Acessível para pessoas com deficiência'
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
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
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
    click_on 'Editar'
    fill_in 'Dimensão em m²', with: 300
    fill_in 'Descrição', with: 'Tema brasileiro'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Quarto atualizado com sucesso'
    expect(page).to have_content 'Dimensão: 300 m²'
    expect(page).to have_content 'Descrição: Tema brasileiro'
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
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
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
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Valor da diária', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar quarto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Valor da diária não pode ficar em branco'
    expect(room.name).to eq 'Brasil'
    expect(room.daily_rate).to eq 150
  end
end
