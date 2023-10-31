require 'rails_helper'

describe 'User visits home page' do
  it 'and sees the name of the app' do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Pousadaria'
  end
end
