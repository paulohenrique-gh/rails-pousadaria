require 'rails_helper'

describe 'Guest visits my-reservations page' do
  it 'and there is no reservation' do
    # Arrange
    guest = Guest.create!(name: 'Pedro Pedrada', document: '012345678910',
                          email: 'pedrada@mail.com', password: 'password')

    # Act
    login_as guest, scope: :guest
    visit root_path
    click_on 'Minhas Reservas'

    # Assert
    expect(page).to have_content 'Você ainda não possui reservas'
  end
end
