require 'rails_helper'

describe '#current_daily_rate' do
  it 'returns value according to seasonal rate' do
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

    room.seasonal_rates.create!(start_date: 5.days.ago,
                                finish_date: 5.days.from_now, rate: 225)
    room.seasonal_rates.create!(start_date: 10.days.ago,
                                finish_date: 6.days.ago, rate: 150)
    room.seasonal_rates.create!(start_date: 7.days.from_now,
                                finish_date: 15.days.from_now, rate: 300)

    # Act
    result = room.current_daily_rate

    # Assert
    expect(result).to eq 225
  end

  it 'returns standard rate' do
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
                                finish_date: 10.days.from_now, rate: 225)

    # Act
    result = room.current_daily_rate

    # Assert
    expect(result).to eq 150
  end
end

describe '#calculate_stay_total' do
  it 'with no seasonal_rate' do
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

    room = Room.new(name: 'Brasil',
                    description: 'Quarto com tema Brasil',
                    dimension: 200, max_people: 3, daily_rate: 150,
                    guesthouse: guesthouse)

    # Act
    result = room.calculate_stay_total(5.days.from_now.to_date,
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

    # Act
    result = room.calculate_stay_total(3.days.from_now.to_date,
                                       25.days.from_now.to_date)

    # Assert
    expect(result).to eq 4875
  end

  pending 'and current time is later than standard checkout'
end
