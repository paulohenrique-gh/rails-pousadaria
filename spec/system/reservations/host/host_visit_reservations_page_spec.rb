require 'rails_helper'

describe 'User visit guesthouse reservations page' do
  it 'from the home page' do
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

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    room.reservations.create!(checkin: 5.days.from_now,
                              checkout: 10.days.from_now, guest_count: 2,
                              stay_total: 900, guest: guest)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('XYZ12345')
    room.reservations.create!(checkin: 15.days.from_now,
                              checkout: 20.days.from_now, guest_count: 1,
                              stay_total: 900, guest: guest, status: :cancelled)


    # Act
    login_as user
    visit root_path
    click_on 'Reservas'

    # Assert
    first_reservation = page.find('.reservation-details:nth-of-type(1)')
    second_reservation = page.find('.reservation-details:nth-of-type(2)')
    expect(page).to have_content 'Reservas de Pousada Bosque'
    expect(page).to have_content 'Código da reserva: ABCD1234'
    expect(page).to have_content 'Quarto: Brasil'
    expect(page).to have_content(
      "Data de entrada: #{5.days.from_now.to_date.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content(
      "Data de saída: #{10.days.from_now.to_date.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content('Quantidade de hóspedes: 2')
    expect(page).to have_content('Status: Confirmada')
    expect(page).to have_content 'Código da reserva: XYZ12345'
    expect(page).to have_content 'Quarto: Brasil'
    expect(page).to have_content(
      "Data de entrada: #{15.days.from_now.to_date.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content(
      "Data de saída: #{20.days.from_now.to_date.strftime('%d/%m/%Y')}"
    )
    expect(page).to have_content('Quantidade de hóspedes: 1')
    expect(page).to have_content('Status: Cancelada')
  end
end
