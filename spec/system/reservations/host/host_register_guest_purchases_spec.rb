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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 1500, guest: guest, room: room,
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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 1500, guest: guest, room: room,
                                      status: :guests_checked_in,
                                      checked_in_at: 1.days.from_now.to_datetime)

    # Act
    travel_to 3.days.from_now do
      login_as user
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar reserva'
      click_on 'Registrar consumo'
      fill_in 'Nome do produto', with: 'Suco de goiaba'
      fill_in 'Valor unitário', with: 4
      fill_in 'Quantidade', with: 2
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Consumo registrado com sucesso'
      expect(reservation.purchases.size).to eq 1
      purchase = reservation.purchases.first
      expect(purchase.product_name).to eq 'Suco de goiaba'
      expect(purchase.price).to eq 4
      expect(purchase.quantity).to eq 2
    end
  end

  it 'and leaves fields empty' do
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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 1500, guest: guest, room: room,
                                      status: :guests_checked_in,
                                      checked_in_at: 1.days.from_now.to_datetime)

    # Act
    travel_to 3.days.from_now do
      login_as user
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar reserva'
      click_on 'Registrar consumo'
      fill_in 'Nome do produto', with: 'Suco de goiaba'
      fill_in 'Valor unitário', with: ''
      fill_in 'Quantidade', with: ''
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Não foi possível registrar consumo'
      expect(page).to have_content 'Valor unitário não pode ficar em branco'
      expect(page).to have_content 'Quantidade não pode ficar em branco'
      expect(reservation.purchases.size).to eq 0
    end
  end

  it 'and is not authenticated' do
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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 1.days.from_now,
                                      checkout: 10.days.from_now, guest_count: 2,
                                      stay_total: 1500, guest: guest, room: room,
                                      status: :guests_checked_in,
                                      checked_in_at: 1.days.from_now.to_datetime)

    # Act
    travel_to 3.days.from_now do
      visit new_reservation_purchase_path(reservation.id)

        # Assert
      expect(current_path).to eq new_user_session_path
    end
  end
end
