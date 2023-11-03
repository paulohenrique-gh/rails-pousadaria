require 'rails_helper'

describe 'User can go back to the homepage' do
  it 'by clicking on the app name' do
    # Act
    visit new_user_session_path
    click_on 'Pousadaria'

    # Assert
    expect(current_path).to eq root_path
  end
end
