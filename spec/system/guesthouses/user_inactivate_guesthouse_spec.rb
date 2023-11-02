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
                                    address: address, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Inativar'

    # Assert
    expect(page).to have_content 'Pousada inativada com sucesso'
    expect(page).not_to have_content 'Pousada Bosque'
    expect(page).not_to have_content 'Telefone: 1130205000'
    expect(page).not_to have_content 'E-mail: atendimento@pousadabosque'
    expect(page).not_to have_content("
      Rua das Pedras, 30, Térreo, Santa Helena, 99000-525, Pulomiranga - RN"
    )
  end
end
