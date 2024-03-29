require 'rails_helper'

describe 'User inactivates seasonal rate' do
  it 'sucessfully' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 10.days.from_now,
                                         finish_date: 20.days.from_now,
                                         rate: 400, room: room)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Mais detalhes'
    within('.seasonal_rates_list') do
      click_on 'Detalhes'
    end
    click_on 'Inativar'

    # Assert
    expect(page).to have_content 'Preço por período excluído com sucesso'
    expect(page).not_to have_content(
      "De #{10.days.from_now.to_date.strftime('%d/%m/%Y')} "\
      "a #{20.days.from_now.to_date.strftime('%d/%m/%Y')}: R$ 400,00"
    )
    expect(seasonal_rate.reload).to be_inactive
  end

  it 'and it is already inactive' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 10.days.from_now,
                                         finish_date: 15.days.from_now,
                                         rate: 400, room: room,
                                         status: :inactive)

    # Act
    login_as user
    visit seasonal_rate_path(seasonal_rate.id)

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Preço por período já inativo'
  end

  it 'and room has reservation in the seasonal period' do
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

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: 10.days.from_now,
                                         finish_date: 20.days.from_now,
                                         rate: 400, room: room)

    reservation = Reservation.create!(checkin: 12.days.from_now,
                                      checkout: 18.days.from_now, guest_count: 2,
                                      stay_total: 900, guest: guest, room: room)

    # Act
    login_as user
    visit seasonal_rate_path(seasonal_rate.id)
    click_on 'Inativar'

    # Assert
    expect(page).to have_content(
      'O quarto possui reservas no período selecionado. Não é possível inativar.'
    )
    expect(seasonal_rate.reload).to be_active
  end
end
