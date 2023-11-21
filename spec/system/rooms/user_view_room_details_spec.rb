require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'User visits room page' do
  it 'and returns to guesthouse page' do
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

    guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150)

    # Act
    login_as user
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Mais detalhes'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq guesthouse_path(guesthouse.id)
    expect(page).to have_content 'Detalhes de Pousada Bosque'
    expect(page).not_to have_content 'Detalhes do quarto Brasil'
  end

  it 'and sees daily rate according to seasonal rate' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.from_now,
                                         finish_date: 15.days.from_now,
                                         rate: 400, room: room)

    # Act
    travel_to 6.days.from_now do
      login_as user
      visit root_path
      click_on 'Pousada Bosque'
      click_on 'Mais detalhes'
    end

    # Assert
    expect(page).to have_content 'Valor da diária: R$ 400,00'
  end

  it 'and is not the owner' do
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

    room = guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150,
                             available: false)

    # Act
    visit room_path(room.id)

    # Assert
    expect(current_path).to eq root_path
  end
end
