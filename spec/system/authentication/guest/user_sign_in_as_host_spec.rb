require 'rails_helper'

describe 'User signs in as guest' do
  it 'successfully' do
    # Arrange
    Guest.create!(name: 'Pedro Pedrada', document: '12345678910',
                  email: 'pedrada@mail.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar como hóspede'
    within '.login_form' do
      fill_in 'E-mail', with: 'pedrada@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    within 'nav' do
      expect(page).not_to have_link 'Entrar como hóspede'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Pedro Pedrada - pedrada@mail.com'
    end
  end
end
