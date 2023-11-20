require 'rails_helper'

describe 'User sign up as host' do
  it 'from the home page' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar como proprietário'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_field 'Confirme sua senha'
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    visit root_path
    click_on 'Entrar como proprietário'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'exemplo@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'

    expect(page).to have_content 'Você realizou seu registro com sucesso!'
    expect(page).to have_content 'exemplo@mail.com'
  end

  it 'and submits blank field' do
    visit new_user_registration_path
    fill_in 'E-mail', with: 'exemplo@mail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível salvar usuário'
  end

  it 'and is redirected to the guesthouse registration page' do
    # Act
    visit new_user_registration_path
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
end
