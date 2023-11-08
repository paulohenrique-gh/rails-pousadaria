require 'rails_helper'

describe 'User visits room page' do
  it 'and see all the details' do
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
                                    address: address, user: user)

    guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150,
                             private_bathroom: true, balcony: true,
                             air_conditioning: true, tv: true, closet: true,
                             safe: true, accessibility: true)

    # Act
    visit root_path
    click_on 'Pousada Bosque'

    # Assert
    expect(page).to have_content 'Brasil'
    expect(page).to have_content 'Quarto com tema Brasil'
    expect(page).to have_content '200 m²'
    expect(page).to have_content 'Capacidade para até 3 pessoas'
    expect(page).to have_content 'Valor da diária: R$ 150'
    expect(page).to have_content 'Disponível para reservas'
    expect(page).to have_content 'Banheiro próprio'
    expect(page).to have_content 'Varanda'
    expect(page).to have_content 'Ar-condicionado'
    expect(page).to have_content 'TV'
    expect(page).to have_content 'Guarda-roupas'
    expect(page).to have_content 'Cofre'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
    within('.seasonal_rates_list') do
      expect(page).not_to have_link 'Editar'
      expect(page).not_to have_button 'Excluir'
    end
    expect(page).not_to have_link 'Editar'

  end

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
                                    address: address, user: user)

    guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Brasil'
    click_on 'Voltar para pousada'

    # Assert
    expect(current_path).to eq guesthouse_path(guesthouse.id)
    expect(page).to have_content 'Detalhes de Pousada Bosque'
    expect(page).not_to have_content 'Detalhes do quarto Brasil'
  end

  it 'and is the owner' do
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
                                    address: address, user: user)

    guesthouse.rooms.create!(name: 'Brasil',
                             description: 'Quarto com tema Brasil',
                             dimension: 200, max_people: 3, daily_rate: 150,
                             available: false)

    # Act
    login_as user
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Brasil'

    # Assert
    expect(page).to have_link 'Editar'
    expect(page).to have_content 'Não disponível para reservas'
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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: 5.days.ago,
                                         finish_date: 5.days.from_now,
                                         rate: 400, room: room)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Brasil'

    # Assert
    expect(page).to have_content 'Valor da diária: R$ 400,00'
  end
end
