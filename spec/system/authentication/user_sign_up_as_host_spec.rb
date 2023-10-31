require 'rails_helper'

describe 'User sign up as host' do
  it 'from the home page' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    select 'Dono de pousada', from: 'Tipo de conta'

    # Assert
    expect(page).to have_field 'Tipo de conta'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_field 'Confirme sua senha'
    expect(page).to have_button 'Salvar'
  end
end
