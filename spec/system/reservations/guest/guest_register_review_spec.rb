require 'rails_helper'

describe 'Guest register review after checkout' do
  it 'from my-reservation page' do
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

    reservation = Reservation.create!(checkin: 5.days.from_now,
                                      checkout: 10.days.from_now,
                                      guest_count: 2, stay_total: 900,
                                      room: room, guest: guest)

    # Act
    reservation.guests_checked_out!
    travel_to 11.days.from_now do
      login_as guest, scope: :guest
      visit root_path
      click_on 'Minhas Reservas'
      click_on 'Gerenciar'
      click_on 'Avaliar'

      # Assert
      expect(page).to have_content 'Avalie sua estadia em Pousada Bosque'
      expect(page).to have_content "Código da reserva: #{reservation.code}"
      expect(page).to have_content 'Classificação geral'
      expect(page).to have_field 'Adicione uma avaliação escrita'
      expect(page).to have_button 'Enviar'
    end
  end
end
