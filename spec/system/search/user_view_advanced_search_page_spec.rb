require 'rails_helper'

describe 'User visits advanced search page' do
  it 'and sees search options' do
    # Act
    visit root_path
    click_on 'Busca avançada'

    # Assert
    expect(page).to have_field 'Nome da pousada'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Aceita pets'
    expect(page).to have_field 'Banheiro no quarto'
    expect(page).to have_field 'Varanda'
    expect(page).to have_field 'Ar-condicionado'
    expect(page).to have_field 'TV'
    expect(page).to have_field 'Guarda-roupas'
    expect(page).to have_field 'Cofre'
    expect(page).to have_field 'Acessível para pessoas com deficiência'
    expect(page).to have_button 'Buscar'
  end

  it 'and gets the correct results' do
    # Arrange
    user_one = User.create!(email: 'usuario1@mail.com', password: 'password1')
    user_two = User.create!(email: 'usuario2@mail.com', password: 'password2')
    user_three = User.create!(email: 'usuario3@mail.com', password: 'password3')

    address_one = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                  neighbourhood: 'São José',
                                  city: 'Pulomiranga', state: 'RN',
                                  postal_code: '99000-525')
    address_two = Address.create!(street_name: 'Rua Carlos Pontes',
                                  number: '450',
                                  neighbourhood: 'Santa Helena',
                                  city: 'Natal', state: 'RN',
                                  postal_code: '99004-100')
    address_three = Address.create!(street_name: 'Rua Teresa Cristina',
                                    number: '55',
                                    neighbourhood: 'Santa Teresa',
                                    city: 'Teresina', state: 'PI',
                                    postal_code: '72655-100')

    guesthouse_one = Guesthouse.create!(brand_name: 'Santa Helena',
                                        corporate_name: 'Uno LTDA',
                                        registration_number: '000000000001',
                                        phone_number: '1131111111',
                                        email: 'uno@uno.com',
                                        pet_policy: true,
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_one, user: user_one)
    guesthouse_two = Guesthouse.create!(brand_name: 'Helena Inn',
                                        corporate_name: 'Dualidade LTDA',
                                        registration_number: '0202020202',
                                        phone_number: '1132222222',
                                        email: 'dualidade@dualidade.com',
                                        pet_policy: true,
                                        checkin_time: '08:00',
                                        checkout_time: '18:00',
                                        address: address_two, user: user_two)
    guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Três Reis',
                                 corporate_name: 'Pousada Três Reis LTDA',
                                 registration_number: '0333033333',
                                 phone_number: '1130333333',
                                 email: 'tresreis@tresreis.com',
                                 checkin_time: '08:00',
                                 checkout_time: '18:00',
                                 address: address_three, user: user_three)

    room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                        dimension: 200, max_people: 3, daily_rate: 150,
                        air_conditioning: true, guesthouse: guesthouse_one)
    room_two = Room.create!(name: 'EUA', description: 'Quarto com tema América',
                        dimension: 400, max_people: 5, daily_rate: 300,
                        air_conditioning: true, guesthouse: guesthouse_two)

    # Act
    visit root_path
    click_on 'Busca avançada'
    fill_in 'Nome da pousada', with: 'helena'
    check 'Aceita pets'
    check 'Ar-condicionado'
    within '.advanced_search_form' do
      click_on 'Buscar'
    end

    # Assert
    first_result = page.find('.search_result_list-item:nth-child(1)')
    second_result = page.find('.search_result_list-item:nth-child(2)')
    expect(page).to have_content '2 resultados encontrados'
    expect(page).to have_content 'Nome fantasia: "helena"'
    expect(page).to have_content 'Aceita pets'
    expect(page).to have_content 'Possui ar-condicionado'
    expect(first_result).to have_link 'Helena Inn'
    expect(second_result).to have_link 'Santa Helena'
    expect(page).not_to have_content 'Pousada Três Reis'
  end
end
