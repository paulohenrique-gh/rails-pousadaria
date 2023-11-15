require 'rails_helper'

describe 'User confirms reservation' do
  it 'successfully' do
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

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        private_bathroom: true, tv: true,
                        guesthouse: guesthouse)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')

    # Act
    login_as guest, scope: :guest
    visit root_path
    click_on 'Pousada Bosque'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: 10.days.from_now.strftime('%d/%m/%Y')
    fill_in 'Data de saída', with: 20.days.from_now.strftime('%d/%m/%Y')
    fill_in 'Quantidade de hóspedes', with: 2
    click_on 'Verificar disponibilidade'
    click_on 'Confirmar reserva'

    # Assert
    expect(page).to have_content 'Reserva registrada com sucesso'
    expect(page).to have_content 'Minhas reservas'
    expect(page).to have_content 'Código da reserva: ABCD1234'
    expect(page).to have_content 'Nome da pousada: Pousada Bosque'
    expect(page).to have_content "Data de entrada: #{10.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Data de saída: #{20.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_button 'Cancelar reserva'
  end
end
