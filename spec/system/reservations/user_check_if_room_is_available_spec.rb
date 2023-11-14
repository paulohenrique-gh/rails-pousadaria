require 'rails_helper'

describe 'User checks if room is available' do
  it 'from the room list in the guesthouse page' do
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
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'

    # Assert
    expect(page).to have_content 'Realizar reserva'
    expect(page).to have_content 'Quarto Brasil'
    expect(page).to have_content 'Quarto com tema Brasil'
    expect(page).to have_content 'Capacidade para até 3 pessoa(s)'
    expect(page).to have_content 'Valor da diária: R$ 150,00'
    expect(page).to have_content 'Disponível para reservas'
    expect(page).to have_content 'Banheiro próprio'
    expect(page).to have_content 'TV'
    expect(page).to have_field 'Data de entrada'
    expect(page).to have_field 'Data de saída'
    expect(page).to have_field 'Quantidade de hóspedes'
    expect(page).to have_button 'Verificar disponibilidade'
  end

  it 'and room is available' do
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
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    # Act
    checkin = 10.days.from_now
    checkout = 20.days.from_now
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: checkin
    fill_in 'Data de saída', with: checkout
    fill_in 'Quantidade de hóspedes', with: 2
    click_on 'Verificar disponibilidade'

    # Assert
    expect(page).to have_content 'Quarto disponível no período informado'
    expect(page).to have_content "Data de entrada: #{checkin.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Data de saída: #{checkout.strftime('%d/%m/%Y')}"
    expect(page).to have_content 'Quantidade de hóspedes: 2'
    expect(page).to have_content 'Valor total das diárias: R$ 1.650,00'
    expect(page).to have_button 'Confirmar reserva'
  end

  it 'and room is not available' do
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
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 10.days.from_now,
                                      checkout: 15.days.from_now,
                                      guest_count: 3, stay_total: 900,
                                      room: room)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: 12.days.from_now
    fill_in 'Data de saída', with: 20.days.from_now
    fill_in 'Quantidade de hóspedes', with: 2
    click_on 'Verificar disponibilidade'

    # Assert
    expect(page).to have_content 'Quarto não disponível no período informado'
  end

  it 'and guest count exceeds room capacity' do
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
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: 10.days.from_now
    fill_in 'Data de saída', with: 20.days.from_now
    fill_in 'Quantidade de hóspedes', with: 5
    click_on 'Verificar disponibilidade'

    # Assert
    expect(page).to have_content 'Número de hóspedes excede capacidade do quarto'
  end
end
