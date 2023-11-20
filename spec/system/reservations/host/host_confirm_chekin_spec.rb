require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Host confirms checkin' do
  it 'from the reservations page' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                          email: 'pedrada@mail.com', password: 'password')

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

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 900, guest: guest, room: room)

    # Act
    travel_to 2.days.from_now
    login_as user
    visit root_path
    click_on 'Reservas'
    click_on 'Gerenciar reserva'
    travel_back

    # Assert
    expect(page).to have_content "Gerenciar reserva #{reservation.code}"
    expect(page).to have_content(
      "Data agendada para entrada: #{reservation.checkin.to_date
                                                .strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content(
      "Data agendada para saída: #{reservation.checkout.to_date
                                              .strftime('%d/%m/%Y')}"
    )
    expect(page).to have_button 'Confirmar check-in'
  end

  it 'between checkin and checkout dates' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                          email: 'pedrada@mail.com', password: 'password')

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

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 900, guest: guest, room: room)

    # Act
    travel_to 2.days.from_now
    login_as user
    visit root_path
    click_on 'Reservas'
    click_on 'Gerenciar reserva'
    click_on 'Confirmar check-in'
    travel_back

    # Assert
    expect(current_path).to eq manage_reservation_path(reservation.id)
    expect(page).to have_content 'Check-in confirmado com sucesso'
    expect(page).to have_content(
      "Data e hora do check-in: #{reservation.reload.checked_in_at
                                             .strftime('%d/%m/%Y %H:%M:%S')}"
    )
    expect(page).not_to have_button 'Confirmar check-in'
    expect(reservation.guests_checked_in?).to be true
  end

  it 'before checkin date' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                          email: 'pedrada@mail.com', password: 'password')

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

    reservation = Reservation.create!(checkin: 2.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 900, guest: guest, room: room)

    # Act
    login_as user
    visit my_guesthouse_reservations_path

    # Assert
    expect(page).not_to have_button 'Confirmar check-in'
  end
end
