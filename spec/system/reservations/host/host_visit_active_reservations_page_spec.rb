require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Host visits active reservations page' do
  it 'from the home page' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                          email: 'pedrada@mail.com', password: 'password')
    guest = Guest.create!(name: 'Manco', document: '012345678910',
                          email: 'mancada@mail.com', password: 'password')

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
                                      stay_total: 900, guest: guest, room: room,
                                      status: :guests_checked_in,
                                      checked_in_at: 1.days.from_now.to_datetime)

    # Act
    travel_to 1.day.from_now
    login_as user
    visit root_path
    click_on 'Estadias Ativas'
    travel_back

    # Assert
    expect(page).to have_content 'Estadias ativas em Pousada Bosque'
    expect(page).to have_content "Código da reserva: #{reservation.code}"
    expect(page).to have_content 'Quarto: Brasil'
    expect(page).to have_content(
      "Data agendada para entrada: #{reservation.checkin.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content(
      "Data agendada para saída: #{reservation.checkout.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content(
      "Data e hora do check-in: #{(reservation.checked_in_at - 3.hours)
                                              .strftime('%d/%m/%Y %H:%M:%S')}"
    )
    expect(page).to have_link 'Gerenciar reserva'
  end
end
