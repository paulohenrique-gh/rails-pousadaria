require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    it 'returns false when street_name is empty' do
      # Arrange
      address = Address.create(street_name: '', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns false when number is empty' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns false when neighbourhood is empty' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: '',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns false when city is empty' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: '', state: 'RN',
                                postal_code: '99000-525')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns false when state is empty' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: '',
                                postal_code: '99000-525')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns false when postal_code is empty' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '')

      # Assert
      expect(address).not_to be_valid
    end

    it 'returns true when all required arguments are given' do
      # Arrange
      address = Address.create(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Assert
      expect(address).to be_valid
    end
  end
end
