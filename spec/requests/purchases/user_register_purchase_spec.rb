require 'rails_helper'

describe 'User registers guest purchase' do
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
      post(reservation_purchases_path(reservation.id),
           params: { product_name: 'Pastel', price: 6.5, quantity: 2 })

      # Assert
      expect(response).to redirect_to new_user_session_path
      expect(reservation.reload.purchases.size).to eq 0
    end
  end

  it 'and is not the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outro@mail.com', password: 'password')

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

    session = { reservation_id: reservation.id }
    allow_any_instance_of(PurchasesController).to receive(:session).and_return(session)

    # Act
    travel_to 3.days.from_now do
      login_as other_user
      post(reservation_purchases_path(reservation.id),
           params: { product_name: 'Pastel', price: 6.5, quantity: 2 })

      # Assert
      expect(response).to redirect_to root_path
      expect(reservation.reload.purchases.size).to eq 0
    end
  end
end
