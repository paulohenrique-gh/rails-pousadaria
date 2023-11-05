require 'rails_helper'

describe 'User edits seasonal rate' do
  it 'from the room details page' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.ago,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Brasil'
    within('.seasonal_rates_list') do
      click_on 'Editar'
    end

    # Assert
    expect(page).to have_content 'Pousada Bosque - Quarto Brasil'
    expect(page).to have_content 'Editar preço por período'
    expect(page).to have_field 'Data inicial'
    expect(page).to have_field 'Data final'
    expect(page).to have_field 'Valor'
    expect(page).to have_button 'Enviar'
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.ago,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    visit edit_guesthouse_room_seasonal_rate_path(guesthouse.id,room.id,
                                                  seasonal_rate.id)

    # Assert
    expect(current_path).to eq(new_user_session_path)
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.ago,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    login_as other_user
    visit edit_guesthouse_room_seasonal_rate_path(guesthouse.id,room.id,
                                                  seasonal_rate.id)

    # Assert
    expect(current_path).to eq new_guesthouse_path
    expect(page).to have_content(
      'Você não tem autorização para alterar esta pousada'
    )
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: '2023-11-10',
                                         finish_date: '2023-11-15',
                                         rate: 400, room: room)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Brasil'
    within('.seasonal_rates_list') do
      click_on 'Editar'
    end
    fill_in 'Data inicial', with: '10/12/2023'
    fill_in 'Data final', with: '15/12/2023'
    fill_in 'Valor', with: 350
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Preço por período atualizado com sucesso'
    expect(page).to have_content 'De 10/12/2023 a 15/12/2023: R$ 350,00'
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: '2023-11-10',
                                         finish_date: '2023-11-15',
                                         rate: 400, room: room)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Brasil'
    within('.seasonal_rates_list') do
      click_on 'Editar'
    end
    fill_in 'Data inicial', with: ''
    click_on 'Enviar'

    # assert
    expect(page).to have_content 'Não foi possível atualizar preço por período'
    expect(page).to have_content 'Data inicial não pode ficar em branco'
  end
end
