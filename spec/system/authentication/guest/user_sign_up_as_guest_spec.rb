require 'rails_helper'

describe 'User signs up as guest' do
  it 'before confirming reservation' do
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
    fill_in 'Data de entrada', with: 10.days.from_now
    fill_in 'Data de saída', with: 20.days.from_now
    fill_in 'Quantidade de hóspedes', with: 2
    click_on 'Verificar disponibilidade'
    click_on 'Confirmar reserva'
    click_on 'Criar conta'

    # Assert
    expect(current_path).to eq new_guest_registration_path
    expect(page).to have_field 'Nome completo'
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_field 'Confirme sua senha'
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    # Act
    visit new_guest_registration_path
    fill_in 'Nome completo', with: 'Pedro Pedrada'
    fill_in 'CPF', with: '12345678910'
    fill_in 'E-mail', with: 'pedrada@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Você realizou seu registro com sucesso!'
    expect(page).to have_content 'pedrada@mail.com'
  end

  it 'and leaves required fields empty' do
    # Act
    visit new_guest_registration_path
    fill_in 'Nome completo', with: 'Pedro Pedrada'
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Não foi possível salvar hóspede'
  end
end
