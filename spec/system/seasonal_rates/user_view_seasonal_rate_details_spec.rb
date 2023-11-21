require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'User visits seasonal rate details' do
  it 'from the room details page' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 2.days.from_now,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    travel_to 3.days.from_now do
      login_as user
      visit root_path
      click_on 'Minha Pousada'
      within('.room_details_list') do
        click_on 'Mais detalhes'
      end

      within('.seasonal_rates_list') do
        click_on 'Detalhes'
      end
    end

    # Assert
    formatted_starting_date = 2.days.from_now.strftime('%d/%m/%Y')
    formatted_finish_date = 5.days.from_now.strftime('%d/%m/%Y')
    formatted_creation_date = seasonal_rate.created_at
                                           .strftime('%d/%m/%Y %H:%M:%S')

    expect(page).to have_content 'Pousada Bosque - Quarto Brasil'
    expect(page).to have_content "Data inicial: #{formatted_starting_date}"
    expect(page).to have_content "Data final: #{formatted_finish_date}"
    expect(page).to have_content 'Valor: R$ 400,00'
    expect(page).to have_content "Criado em: #{formatted_creation_date}"
    expect(page).to have_button 'Inativar'
  end

  it 'and must be authenticated' do
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

    seasonal_rate = SeasonalRate.create!(start_date: 2.days.from_now,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    visit seasonal_rate_path(seasonal_rate.id)

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'and must be the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: '123456')
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

    seasonal_rate = SeasonalRate.create!(start_date: 2.days.from_now,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    login_as other_user
    visit seasonal_rate_path(seasonal_rate.id)

    # Assert
    expect(current_path).to eq new_guesthouse_path
    expect(page).to have_content(
      'Você não tem autorização para alterar esta pousada'
    )
  end
end
