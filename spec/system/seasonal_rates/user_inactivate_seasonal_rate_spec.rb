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
                                    address: address, user: user)

    room = Room.create!(name: 'Brasil',
                        description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        guesthouse: guesthouse)

    seasonal_rate = SeasonalRate.create!(start_date: '2023-11-10',
                                         finish_date: '2023-11-15',
                                         rate: 400, room: room)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Brasil'
    within('.seasonal_rates_list') do
      click_on 'Editar'
    end
    click_on 'Excluir'

    # Assert
    expect(page).to have_content 'Preço por período excluído com sucesso'
    expect(page).not_to have_content 'De 10/11/2023 a 15/11/2023: R$ 400,00'
    expect(seasonal_rate.reload).to be_inactive
  end
end