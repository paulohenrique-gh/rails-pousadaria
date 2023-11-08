require 'rails_helper'

describe 'User adds a seasonal rate to a room' do
  it 'and it must not overlap with existing seasonal rates' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)
    room.seasonal_rates.create!(start_date: '2023-12-01',
                                finish_date: '2023-12-31', rate: 100)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within('.room_details_list') do
      click_on 'Mais detalhes'
    end

    click_on 'Adicionar preço por período'
    fill_in 'Data inicial', with: '24/12/2023'
    fill_in 'Data final', with: '30/12/2023'
    fill_in 'Valor', with: 250
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível cadastrar preço por período'
    expect(page).to have_content 'Data inicial dentro de período já cadastrado'
    expect(page).to have_content 'Data final dentro de período já cadastrado'
  end
end
