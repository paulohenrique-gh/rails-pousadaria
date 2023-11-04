require 'rails_helper'

describe 'User adds seasonal rate to room' do
  it 'from the room editing page' do
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

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Brasil'
    click_on 'Editar'
    click_on 'Adicionar preço por período'

    # Assert
    expect(page).to have_content 'Pousada Bosque - Quarto Brasil'
    expect(page).to have_content 'Adicionar preço por período'
    expect(page).to have_field 'Data inicial'
    expect(page).to have_field 'Data final'
    expect(page).to have_field 'Valor'
    expect(page).to have_button 'Enviar'
  end

  pending 'successfully'
  pending 'and leaves required fields empty'
  pending 'and must be authenticated'
  pending 'and must be the owner'
end
