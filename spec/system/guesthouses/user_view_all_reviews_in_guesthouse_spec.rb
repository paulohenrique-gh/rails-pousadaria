require 'rails_helper'

describe 'User visits a guesthouse reviews page' do
  it 'and sees the correct details with reviews' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
                          email: 'pedrada@mail.com', password: 'password')
    other_guest = Guest.create!(name: 'Manco Mancada', document: '10987654321',
                                email: 'mancada@mail.com', password: 'password')

    address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                              complement: 'Térreo',
                              neighbourhood: 'Santa Helena',
                              city: 'Pulomiranga', state: 'RN',
                              postal_code: '99000-525')
    guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
      corporate_name: 'Pousada Ramos Faria LTDA',
      registration_number: '02303221000152', phone_number: '1130205000',
      email: 'atendimento@pousadabosque',
      description: 'Pousada tranquila no interior do Rio Grande do Norte',
      payment_method_one: 'Pix', payment_method_two: 'Cartão de crédito',
      payment_method_three: 'Dinheiro', pet_policy: true,
      guesthouse_policy: 'Não é permitido uso de bebida alcoólica',
      checkin_time: '08:00', checkout_time: '20:00',
      address: address, user: user
    )

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, balcony: true,
                        air_conditioning: true, tv: true, closet: true,
                        safe: true, accessibility: true, guesthouse: guesthouse)

    reservation = Reservation.create!(checkin: 2.days.from_now,
                                      checkout: 4.days.from_now,
                                      guest_count: 1, stay_total: 450,
                                      room: room, guest: guest,
                                      status: :guests_checked_out,
                                      checked_in_at: 2.days.from_now,
                                      checked_out_at: 4.days.from_now,
                                      payment_method: 'Dinheiro')
    reservation_two = Reservation.create!(checkin: 5.days.from_now,
                                          checkout: 10.days.from_now,
                                          guest_count: 2, stay_total: 900,
                                          room: room, guest: other_guest,
                                          status: :guests_checked_out,
                                          checked_in_at: 6.days.from_now,
                                          checked_out_at: 10.days.from_now,
                                          payment_method: 'Dinheiro')
    reservation_three = Reservation.create!(checkin: 11.days.from_now,
                                            checkout: 15.days.from_now,
                                            guest_count: 2, stay_total: 750,
                                            room: room, guest: other_guest,
                                            status: :guests_checked_out,
                                            checked_in_at: 11.days.from_now,
                                            checked_out_at: 14.days.from_now,
                                            payment_method: 'Dinheiro')
    reservation_four = Reservation.create!(checkin: 17.days.from_now,
                                          checkout: 20.days.from_now,
                                          guest_count: 2, stay_total: 600,
                                          room: room, guest: guest,
                                          status: :guests_checked_out,
                                          checked_in_at: 17.days.from_now,
                                          checked_out_at: 20.days.from_now,
                                          payment_method: 'Dinheiro')

    review = Review.create!(rating: 4, description: 'Muito bom',
                            reservation: reservation)
    review_two = Review.create!(rating: 5, description: 'Bem tranquilo',
                                  reservation: reservation_two)
    review_three = Review.create!(rating: 4, description: 'Bacana',
    reservation: reservation_three)
    review_four = Review.create!(rating: 2, description: 'Muito quente',
    reservation: reservation_four)

    avarage_rating = guesthouse.reviews.average(:rating).to_f

    # Act
    travel_to 12.days.from_now do
      visit root_path
      click_on 'Pousada Bosque'
      click_on 'Visualizar todas'

      # Assert
      expect(page).to have_content 'Avaliações - Pousada Bosque'
      expect(page).to have_content "Média: ★ #{avarage_rating}"
      expect(page).to have_content(
        "Pedro Pedrada, "\
        "#{I18n.localize(review_four.created_at.to_date)}\n"\
        "Nota 2 - Muito quente"
      )
      expect(page).to have_content(
        "Manco Mancada, "\
        "#{I18n.localize(review_three.created_at.to_date)}\n"\
        "Nota 4 - Bacana"
      )
      expect(page).to have_content(
        "Manco Mancada, "\
        "#{I18n.localize(review_two.created_at.to_date)}\n"\
        "Nota 5 - Bem tranquilo"
      )
      expect(page).to have_content(
        "Pedro Pedrada, "\
        "#{I18n.localize(review.created_at.to_date)}\n"\
        "Nota 4 - Muito bom"
      )
      expect(page).to have_link 'Voltar'
    end
  end
end
