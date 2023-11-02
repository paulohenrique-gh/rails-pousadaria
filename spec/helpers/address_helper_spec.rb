require 'rails_helper'

RSpec.describe AddressHelper, type: :helper do
  describe '#full_address_string' do
    it 'returns the correct string with complement' do
      # Arrange
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                complement: 'Térreo',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Act
      address_string = full_address_string(address)

      # Assert
      expect(address_string).to eq(
        'Rua das Pedras, 30, Térreo, Santa Helena, 99000-525, Pulomiranga - RN'
      )
    end

    it 'returns the correct string without complement' do
      # Arrange
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      # Act
      address_string = full_address_string(address)

      # Assert
      expect(address_string).to eq(
        'Rua das Pedras, 30, Santa Helena, 99000-525, Pulomiranga - RN'
      )
    end
  end
end
