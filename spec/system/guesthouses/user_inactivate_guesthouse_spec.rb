require 'rails_helper'

describe 'User inactivates a guesthouse' do
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
                                    checkin_time: '08:00', checkout_time: '18:00',
                                    address: address, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Inativar'

    # Assert
    expect(page).to have_content 'Pousada inativada com sucesso'
    expect(page).not_to have_content 'Pousada Bosque'
    expect(page).not_to have_content 'Pulomiranga'
    expect(guesthouse.reload).to be_inactive
  end
end

describe 'User reactivates a guesthouse' do
  it 'successfully' do
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
                                    checkin_time: '08:00', checkout_time: '18:00',
                                    address: address, user: user,
                                    status: :inactive)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Reativar'

    # Assert
    expect(page).to have_content 'Pousada reativada com sucesso'
    expect(guesthouse.reload).to be_active
  end
end
