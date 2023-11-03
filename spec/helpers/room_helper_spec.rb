require 'rails_helper'

RSpec.describe RoomHelper, type: :helper do
  describe '#extra_features?' do
    it 'returns false when no feature is present' do
      # Arrange
      room = Room.new(name: 'Brasil', description: 'Quarto com tema Brasil',
                      dimension: 200, max_people: 3, daily_rate: 150,
                      private_bathroom: false, balcony: false,
                      air_conditioning: false, tv: false, closet: false,
                      safe: false, accessibility: false)

      # Act
      result = extra_features?(room)

      # Assert
      expect(result).to be false
    end

    it 'returns true when at least one feature is present' do
      # Arrange
      room = Room.new(name: 'Brasil', description: 'Quarto com tema Brasil',
                      dimension: 200, max_people: 3, daily_rate: 150,
                      private_bathroom: true, balcony: false,
                      air_conditioning: false, tv: false, closet: false,
                      safe: false, accessibility: false)

      # Act
      result = extra_features?(room)

      # Assert
      expect(result).to be true
    end
  end

  describe '#extra_features_collection' do
    it 'returns an array of strings representing available features' do
      # Arrange
      room = Room.new(name: 'Brasil', description: 'Quarto com tema Brasil',
                      dimension: 200, max_people: 3, daily_rate: 150,
                      private_bathroom: true, balcony: true,
                      air_conditioning: true, tv: true, closet: true,
                      safe: true, accessibility: true)

      # Act
      result = extra_features_collection(room)

      # Assert
      expected_collection = ['Banheiro próprio', 'Varanda', 'Ar-condicionado',
                             'TV', 'Guarda-roupas', 'Cofre',
                             'Acessível para pessoas com deficiência']
      expect(result).to eq expected_collection
    end

    it 'returns an empty array when no feature is present' do
      # Arrange
      room = Room.new(name: 'Brasil', description: 'Quarto com tema Brasil',
                      dimension: 200, max_people: 3, daily_rate: 150,
                      private_bathroom: false, balcony: false,
                      air_conditioning: false, tv: false, closet: false,
                      safe: false, accessibility: false)

      # Act
      result = extra_features_collection(room)

      # Assert
      expect(result).to be_empty
    end
  end
end
