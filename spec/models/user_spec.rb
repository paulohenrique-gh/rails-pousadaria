require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'returns false when email is empty' do
      # Arrange
      user = User.create(email: '', password: 'password')

      # Assert
      expect(user).not_to be_valid
    end

    it 'returns false when password is empty' do
      # Arrange
      user = User.create(email: 'user@mail.com', password: '')

      # Assert
      expect(user).not_to be_valid
    end

    it 'returns true when all required arguments are given' do
      # Arrange
      user = User.create(email: 'user@mail.com', password: 'password')

      # Assert
      expect(user).to be_valid
    end
  end
end
