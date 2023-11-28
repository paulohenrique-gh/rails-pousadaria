require 'rails_helper'

describe 'Host registers guest purchases' do
  it 'from the reservation management page' do
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
                                    checkin_time: '10:00',
                                    checkout_time: '14:00',
                                    payment_method_one: 'Dinheiro',
                                    payment_method_two: 'Cartão de crédito',
                                    payment_method_three: 'Pix',
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.from_now,
                                        finish_date: 7.days.from_now,
                                        rate: 250, room: room)

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 1800, guest: guest, room: room,
                                      status: :guests_checked_in,
                                      checked_in_at: 1.days.from_now.to_datetime)

    # Act
    travel_to 3.days.from_now do
      login_as user
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar reserva'
      click_on 'Registrar consumo'

      # Assert
      expect(page).to have_content 'Registrar consumo'
      expect(page).to have_field 'Nome do produto'
      expect(page).to have_field 'Valor unitário'
      expect(page).to have_field 'Quantidade'
      expect(page).to have_button 'Enviar'
    end
  end
end
