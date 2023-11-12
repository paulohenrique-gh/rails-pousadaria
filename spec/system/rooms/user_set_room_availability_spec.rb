require 'rails_helper'

describe 'User marks room as unavailable' do
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
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)


    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse, available: true)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Mais detalhes'
    click_on 'Editar'
    uncheck 'Disponível para reservas'
    click_on 'Enviar'

    # Assert
    room.reload
    expect(room).not_to be_available
    expect(page).to have_content 'Não disponível para reservas'
  end

  it 'and guest can only see available rooms' do
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
                        guesthouse: guesthouse, available: false)
    other_room = Room.create!(name: 'Suécia', description: 'Tema sueco',
                              dimension: 400, max_people: 3, daily_rate: 580,
                              guesthouse: guesthouse, available: true)

    # Act
    visit root_path
    click_on 'Pousada Bosque'

    # Assert
    expect(page).not_to have_content 'Brasil'
    expect(page).not_to have_content 'Quarto com tema Brasil'
    expect(page).to have_content 'Suécia'
    expect(page).to have_content 'Tema sueco'
  end
end

describe 'User marks room as available' do
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
                        guesthouse: guesthouse, available: false)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Mais detalhes'
    click_on 'Editar'
    check 'Disponível para reservas'
    click_on 'Enviar'

    # Assert
    room.reload
    expect(room).to be_available
    expect(page).to have_content 'Disponível para reservas'
  end

  it 'and host can see all rooms in their guesthouse page' do
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
                        guesthouse: guesthouse, available: false)
    other_room = Room.create!(name: 'Suécia', description: 'Tema sueco',
                              dimension: 400, max_people: 3, daily_rate: 580,
                              guesthouse: guesthouse, available: true)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'

    # Assert
    within('.room_details_list') do
      expect(page).to have_content 'Suécia'
      expect(page).to have_content 'Brasil'
    end
  end
end
