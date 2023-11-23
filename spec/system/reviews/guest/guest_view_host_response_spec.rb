require 'rails_helper'

describe 'Guest visit reservation management page' do
  it 'and sees response from the host' do
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

    review = Review.create!(rating: 4, description: 'Muito bom',
                            reservation: reservation)

    # Act
    travel_to 5.days.from_now do
      review.response = 'Obrigado'
      review.save
      login_as guest, scope: :guest
      visit root_path
      click_on 'Minhas Reservas'
      click_on 'Gerenciar'

      # Assert
      expect(page).to have_content(
        "Resposta do proprietário em #{I18n.localize(review.updated_at.to_date)}: Obrigado"
      )
    end
  end
end
