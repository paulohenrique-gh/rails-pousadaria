# require 'rails_helper'

# describe 'User visits guesthouse details page' do
#   it 'and can see the reviews' do
#     # Arrange
#     user = User.create!(email: 'exemplo@mail.com', password: 'password')

#     guest = Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
#                           email: 'pedrada@mail.com', password: 'password')
#     other_guest = Guest.create!(name: 'Manco Mancada', document: '10987654321',
#                                 email: 'mancada@mail.com', password: 'password')

#     address = Address.create!(street_name: 'Rua das Pedras', number: '30',
#                               neighbourhood: 'Santa Helena',
#                               city: 'Pulomiranga', state: 'RN',
#                               postal_code: '99000-525')

#     guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
#                                     corporate_name: 'Pousada Ramos Faria LTDA',
#                                     registration_number: '02303221000152',
#                                     phone_number: '1130205000',
#                                     email: 'atendimento@pousadabosque',
#                                     checkin_time: '08:00',
#                                     checkout_time: '18:00',
#                                     address: address, user: user)

#     room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
#                         dimension: 200, max_people: 3, daily_rate: 150,
#                         private_bathroom: true, tv: true,
#                         guesthouse: guesthouse)

#     reservation = Reservation.create!(checkin: 2.days.from_now,
#                                       checkout: 4.days.from_now,
#                                       guest_count: 1, stay_total: 450,
#                                       room: room, guest: guest,
#                                       status: :guests_checked_out,
#                                       checked_in_at: 2.days.from_now,
#                                       checked_out_at: 4.days.from_now,
#                                       payment_method: 'Dinheiro')
#     other_reservation = Reservation.create!(checkin: 5.days.from_now,
#                                             checkout: 10.days.from_now,
#                                             guest_count: 2, stay_total: 900,
#                                             room: room, guest: other_guest,
#                                             status: :guests_checked_out,
#                                             checked_in_at: 6.days.from_now,
#                                             checked_out_at: 10.days.from_now,
#                                             payment_method: 'Dinheiro')

#     review = Review.create!(rating: 4, description: 'Muito bom',
#                             reservation: reservation)
#     other_review = Review.create!(rating: 5, description: 'Bem tranquilo',
#                                   reservation: other_reservation)

#     # Act
#     travel_to 12.days.from_now do
#       other_review.response = 'Excelente hóspede'
#       other_review.save
#       visit root_path
#       click_on 'Pousada Bosque'

#     end
#   end
# end
