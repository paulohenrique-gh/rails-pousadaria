require 'rails_helper'

describe 'User signs in' do
  it 'successfully' do
    # Arrange
    User.create!(email: 'exemplo@mail.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within '.login_form' do
      fill_in 'E-mail', with: 'exemplo@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'exemplo@mail.com'
    end
  end

  it 'and gives wrong credentials' do
    # Arrange
    User.create!(email: 'exemplo@mail.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within '.login_form' do
      fill_in 'E-mail', with: 'exemplo@mail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválidos'
  end

  it 'and signs out' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end
