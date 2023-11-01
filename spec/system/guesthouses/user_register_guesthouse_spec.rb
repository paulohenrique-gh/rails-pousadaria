require 'rails_helper'

describe 'User registers guesthouse' do
  it 'from the home page' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Cadastrar Pousada'

    # Assert
    expect(page).to have_content 'Cadastro de Pousada'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Logradouro'
    expect(page).to have_field 'Número'
    expect(page).to have_field 'Complemento'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Método de pagamento 1'
    expect(page).to have_field 'Método de pagamento 2'
    expect(page).to have_field 'Método de pagamento 3'
    expect(page).to have_field 'Aceita pets'
    expect(page).to have_field 'Políticas de uso'
    expect(page).to have_field 'Horário de check-in'
    expect(page).to have_field 'Horário de check-out'
    expect(page).to have_button 'Enviar'
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Cadastrar Pousada'
    fill_in 'Nome Fantasia', with: 'Pousada Bosque'
    fill_in 'Razão Social', with: 'Pousada Ramos Faria LTDA'
    fill_in 'CNPJ', with: '02303221000152'
    fill_in 'Telefone', with: '1130205000'
    fill_in 'E-mail', with: 'atendimento@pousadabosque'
    fill_in 'Logradouro', with: 'Rua das Pedras'
    fill_in 'Número', with: '30'
    fill_in 'Complemento', with: 'Térreo'
    fill_in 'Bairro', with: 'Santa Helena'
    fill_in 'CEP', with: '99000-525'
    fill_in 'Cidade', with: 'Pulomiranga'
    fill_in 'Estado', with: 'RN'
    fill_in 'Descrição', with: 'Pousada em local tranquilo no interior do Rio Grande do Norte'
    fill_in 'Método de pagamento 1', with: 'Pix'
    fill_in 'Método de pagamento 2', with: 'Cartão de crédito'
    fill_in 'Método de pagamento 3', with: 'Dinheiro'
    check 'Aceita pets'
    fill_in 'Políticas de uso', with: 'Não é permitido uso de bebida alcoólica'
    fill_in 'Horário de check-in', with: '08:00'
    fill_in 'Horário de check-out', with: '20:00'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Pousada cadastrada com sucesso'
    expect(page).to have_content 'Pousada Bosque'
    expect(page).to have_content 'Telefone: 1130205000'
    expect(page).to have_content 'Email: atendimento@pousadabosque'
    expect(page).to have_content 'Rua das Pedras, 30, Térreo, Santa Helena, 99000-525, Pulomiranga - RN'
  end
end
