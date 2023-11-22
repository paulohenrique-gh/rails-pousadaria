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
                                      room: room, guest: guest,
                                      status: :guests_checked_in,
                                      checked_in_at: 6.days.from_now)

    # Act
    reservation.payment_method = 'Dinheiro'
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
      expect(page).to have_content 'Nota'
      expect(page).to have_field 'Adicione uma avaliação escrita'
      expect(page).to have_button 'Enviar'
    end
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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
                                      room: room, guest: guest,
                                      status: :guests_checked_in,
                                      checked_in_at: 6.days.from_now)

    # Act
    reservation.payment_method = 'Dinheiro'
    reservation.guests_checked_out!
    travel_to 11.days.from_now do
      login_as guest, scope: :guest
      visit new_reservation_review_path(reservation.id)
      choose(option: '4')
      fill_in 'Adicione uma avaliação escrita', with: 'Hospedagem muito boa'
      click_on 'Enviar'

      # Assert
      expect(current_path).to eq guest_manage_reservation_path(reservation.id)
      expect(page).to have_content 'Avaliação registrada com sucesso'
      expect(page).to have_content(
        "Avaliação registrada em "\
        "#{reservation.review.created_at.to_date.strftime('%d/%m/%Y')}: "\
        "Hospedagem muito boa"
      )
    end
  end

  it 'and is not authenticated' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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
                                      room: room, guest: guest,
                                      status: :guests_checked_in,
                                      checked_in_at: 6.days.from_now)

    # Act
    reservation.payment_method = 'Dinheiro'
    reservation.guests_checked_out!
    travel_to 11.days.from_now do
      visit new_reservation_review_path(reservation.id)

        # Assert
        expect(current_path).to eq new_guest_session_path
    end
  end

  it "and cannot review other guest's stay" do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
                          email: 'pedrada@mail.com', password: 'password')
    other_guest = Guest.create!(name: 'Manco Mancada', document: '10987654321',
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

    reservation = Reservation.create!(checkin: 5.days.from_now,
                                      checkout: 10.days.from_now,
                                      guest_count: 2, stay_total: 900,
                                      room: room, guest: other_guest,
                                      status: :guests_checked_in,
                                      checked_in_at: 6.days.from_now)

    # Act
    reservation.payment_method = 'Dinheiro'
    reservation.guests_checked_out!
    travel_to 11.days.from_now do
      login_as guest, scope: :guest
      visit new_reservation_review_path(reservation.id)

      # Assert
      expect(current_path).to eq root_path
    end
  end

  it 'and leaves empty fields' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
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
                                      room: room, guest: guest,
                                      status: :guests_checked_in,
                                      checked_in_at: 6.days.from_now)

    # Act
    reservation.payment_method = 'Dinheiro'
    reservation.guests_checked_out!
    travel_to 11.days.from_now do
      login_as guest, scope: :guest
      visit new_reservation_review_path(reservation.id)
      choose(option: '4')
      fill_in 'Adicione uma avaliação escrita', with: ''
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Avaliação escrita não pode ficar em branco'
    end
  end
end
