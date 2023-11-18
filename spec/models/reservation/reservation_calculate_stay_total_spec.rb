require 'rails_helper'

describe '#calculate_stay_total' do
  it 'with no seasonal_rate' do
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

    room = Room.new(name: 'Brasil',
                    description: 'Quarto com tema Brasil',
                    dimension: 200, max_people: 3, daily_rate: 150,
                    guesthouse: guesthouse)

    reservation = Reservation.new(checkin: 5.day.from_now,
                                  checkout: 10.days.from_now, guest_count: 2,
                                  room: room)

    # Act
    result = reservation.calculate_stay_total(5.days.from_now.to_date,
                                              10.days.from_now.to_date)

    # Assert
    expect(result).to eq 900
  end

  it 'with seasonal_rate' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    room.seasonal_rates.create!(start_date: 5.days.from_now,
                                finish_date: 7.days.from_now, rate: 225)
    room.seasonal_rates.create!(start_date: 10.days.from_now,
                                finish_date: 15.days.from_now, rate: 250)
    room.seasonal_rates.create!(start_date: 17.days.from_now,
                                finish_date: 20.days.from_now, rate: 300)

    reservation = Reservation.new(checkin: 3.day.from_now,
                                  checkout: 25.days.from_now, guest_count: 2,
                                  room: room)

    # Act
    result = reservation.calculate_stay_total(3.days.from_now.to_date,
                                              25.days.from_now.to_date)

    # Assert
    expect(result).to eq 4875
  end
end
