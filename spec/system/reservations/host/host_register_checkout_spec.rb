require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Host registers checkout' do
  it 'from my-active-reservations' do
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

    reservation.purchases.create!(product_name: 'Pastel', price: 6.5, quantity: 2)
    reservation.purchases.create!(product_name: 'Pão', price: 0.5, quantity: 15)
    reservation.purchases.create!(product_name: 'Pepsi', price: 11.3, quantity: 1)

    # Act
    travel_to 10.days.from_now.change(hour: 15) do
      login_as user
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar reserva'
      click_on 'Realizar check-out'
    end

    # Assert
    expect(page).to have_content "Check-out da reserva #{reservation.code}"
    expect(page).to have_content(
      "Data e hora do check-in: #{I18n.localize(reservation.checked_in_at,
                                                format: :custom)}"
    )
    expect(page).to have_content 'Valor da estadia até a data atual: R$ 1.950,00'
    expect(page).to have_content "Valor do consumo: R$ 31,80"
    expect(page).to have_content "Valor total a pagar: R$ 1.981,80"
    expect(page).to have_field 'Forma de pagamento'
    expect(page).to have_button 'Confirmar'
  end

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

    reservation.purchases.create!(product_name: 'Pastel', price: 6.5, quantity: 2)
    reservation.purchases.create!(product_name: 'Pão', price: 0.5, quantity: 15)
    reservation.purchases.create!(product_name: 'Pepsi', price: 11.3, quantity: 1)

    # Act
    travel_to 10.days.from_now.change(hour: 9) do
      login_as user
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar reserva'
      click_on 'Realizar check-out'
      select 'Pix', from: 'Forma de pagamento'
      click_on 'Confirmar'
    end

    # Assert
    expect(current_path).to eq user_reservations_path
    expect(page).to have_content 'Estadia finalizada com sucesso'
    expect(reservation.reload.guests_checked_out?).to be true
    expect(reservation.checked_out_at).to eq 10.days.from_now.change(hour: 9)
    expect(reservation.stay_total).to eq 1831.8
    expect(reservation.payment_method).to eq 'Pix'
  end
end
