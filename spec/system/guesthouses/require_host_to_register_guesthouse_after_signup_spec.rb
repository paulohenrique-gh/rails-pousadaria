require 'rails_helper'

describe "User creates host account" do
  it 'and is redirected to the guesthouse registration page' do
    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'user@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq new_guesthouse_path
  end

  it 'and cannot visit home page' do
    # Arrange
    user = User.create!(email: 'user@mail.com', password: 'password')

    # Act
    login_as user
    visit root_path

    # Assert
    expect(current_path).to eq new_guesthouse_path
  end

  it "and cannot visit other people's guesthouse page" do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'password')
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

    # Act
    login_as other_user
    visit guesthouse_path(guesthouse.id)

    # Assert
    expect(current_path).to eq new_guesthouse_path
  end

  it "and cannot visit other people's room page" do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outroexemplo@mail.com',
                              password: 'password')
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
                        guesthouse: guesthouse)
    # Act
    login_as other_user
    visit room_path(room.id)

    # Assert
    expect(current_path).to eq new_guesthouse_path
  end
end
