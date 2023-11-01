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

  it 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    select 'Dono de pousada', from: 'Tipo de conta'
    fill_in 'E-mail', with: 'exemplo@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'

    expect(page).to have_content 'Você realizou seu registro com sucesso!'
    expect(page).to have_content 'exemplo@mail.com'
  end

  it 'and submits blank field' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    select 'Dono de pousada', from: 'Tipo de conta'
    fill_in 'E-mail', with: 'exemplo@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível salvar usuário'
  end
end
