require 'rails_helper'

describe 'Host responds to review' do
  it 'from review page' do
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

    reservation = Reservation.create!(checkin: 2.days.from_now,
                                      checkout: 4.days.from_now,
                                      guest_count: 1, stay_total: 450,
                                      room: room, guest: guest,
                                      status: :guests_checked_out,
                                      checked_in_at: 2.days.from_now,
                                      checked_out_at: 4.days.from_now,
                                      payment_method: 'Dinheiro')

    reservation.create_review!(rating: 4, description: 'Muito bom')

    # Act
    travel_to 15.days.from_now do
      login_as user
      visit root_path
      click_on 'Avaliações'
      click_on 'Responder avaliação'

      # Assert
      expect(page).to have_content 'Pousada Bosque'
      expect(page).to have_content "Código da reserva: #{reservation.code}"
      expect(page).to have_content "Quarto: Brasil"
      expect(page).to have_content 'Nome do hóspede: Pedro Pedrada'
      expect(page).to have_content(
        "Data do checkout: #{I18n.localize(reservation.checked_out_at.to_date)}"
      )
      expect(page).to have_content 'Nota: 4'
      expect(page).to have_content 'Avaliação: Muito bom'
      expect(page).to have_field id: 'review_response'
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

    reservation = Reservation.create!(checkin: 2.days.from_now,
                                      checkout: 4.days.from_now,
                                      guest_count: 1, stay_total: 450,
                                      room: room, guest: guest,
                                      status: :guests_checked_out,
                                      checked_in_at: 2.days.from_now,
                                      checked_out_at: 4.days.from_now,
                                      payment_method: 'Dinheiro')

    reservation.create_review!(rating: 4, description: 'Muito bom')

    # Act
    travel_to 15.days.from_now do
      login_as user
      visit root_path
      click_on 'Avaliações'
      click_on 'Responder avaliação'
      fill_in id: 'review_response', with: 'Grato'
      click_on 'Enviar'

      # Assert
      expect(current_path).to eq user_reviews_path
      expect(page).to have_content 'Resposta registrada com sucesso'
      expect(page).to have_content 'Sua resposta: Grato'
      expect(page).not_to have_link 'Responder avaliação'
    end
  end

  it 'and leaves response field empty' do
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

    reservation = Reservation.create!(checkin: 2.days.from_now,
                                      checkout: 4.days.from_now,
                                      guest_count: 1, stay_total: 450,
                                      room: room, guest: guest,
                                      status: :guests_checked_out,
                                      checked_in_at: 2.days.from_now,
                                      checked_out_at: 4.days.from_now,
                                      payment_method: 'Dinheiro')

    reservation.create_review!(rating: 4, description: 'Muito bom')

    # Act
    travel_to 15.days.from_now do
      login_as user
      visit root_path
      click_on 'Avaliações'
      click_on 'Responder avaliação'
      fill_in id: 'review_response', with: ''
      click_on 'Enviar'

      # Assert
      expect(page).to have_content 'Resposta não pode ficar em branco'
    end
  end
end
