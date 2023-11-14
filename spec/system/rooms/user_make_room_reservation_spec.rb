require 'rails_helper'

describe 'User makes a reservation' do
  it 'from the room list in the guesthouse page' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    # Act
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'

    # Assert
    expect(page).to have_content 'Realizar reserva'
    expect(page).to have_content 'Quarto Brasil'
    expect(page).to have_content 'Quarto com tema Brasil'
    expect(page).to have_content 'Capacidade para até 3 pessoa(s)'
    expect(page).to have_content 'Valor da diária: R$ 150,00'
    expect(page).to have_content 'Disponível para reservas'
    expect(page).to have_content 'Banheiro próprio'
    expect(page).to have_content 'TV'
    expect(page).to have_field 'Data de entrada'
    expect(page).to have_field 'Data de saída'
    expect(page).to have_field 'Quantidade de hóspedes'
    expect(page).to have_button 'Enviar'
  end
end
