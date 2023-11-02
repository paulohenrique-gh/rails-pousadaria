require 'rails_helper'

describe 'User visits home page' do
  it 'and sees the name of the app' do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Pousadaria'
  end

  it "and sees the search bar" do
    # Act
    visit root_path

    # Assert
    expect(page).to have_field 'Buscar pousada'
  end
end
