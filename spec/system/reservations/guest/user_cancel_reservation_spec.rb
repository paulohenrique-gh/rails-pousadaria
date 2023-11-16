require 'rails_helper'

describe 'User cancels reservation' do
  it 'successfully' do
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

    room.reservations.create!(checkin: 10.days.from_now,
                              checkout: 20.days.from_now, guest_count: 2,
                              stay_total: 900, guest: guest)

    # Act
    login_as guest, scope: :guest
    visit root_path
    click_on 'Minhas Reservas'
    click_on 'Cancelar reserva'

    # Assert
    expect(page).to have_content 'Reserva cancelada com sucesso'
    expect(page).to have_content 'Status: Cancelada'
    expect(guest.reservations.first).to be_inactive
  end

  it 'within seven days' do
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

    room.reservations.create!(checkin: 5.days.from_now,
                              checkout: 20.days.from_now, guest_count: 2,
                              stay_total: 900, guest: guest)

    # Act
    login_as guest, scope: :guest
    visit root_path
    click_on 'Minhas Reservas'

    # Assert
    expect(page).not_to have_button 'Cancelar reserva'
  end
end
