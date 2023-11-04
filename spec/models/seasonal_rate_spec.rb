require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#finish_date_is_greater_than_start_date' do
    it 'adds error to object when start_date is greater than finish date' do
      # Arrange
      seasonal_rate = SeasonalRate.new(start_date: '2024-01-01',
                                       finish_date: '2023-12-24',
                                       rate: 200)

      # Act
      seasonal_rate.valid?

      # Assert
      expect(seasonal_rate.errors.include? :finish_date).to be true
      expect(seasonal_rate.errors[:finish_date]).to include(
        'não pode ser menor que data inicial'
      )
    end

    it "doesn't add error to object when finish_date is greater" do
      # Arrange
      seasonal_rate = SeasonalRate.new(start_date: '2024-01-01',
                                       finish_date: '2023-12-24',
                                       rate: 200)

      # Act
      seasonal_rate.valid?

      # Assert
      expect(seasonal_rate.errors.include? :finish_date).to be true
      expect(seasonal_rate.errors[:finish_date]).to include(
        'não pode ser menor que data inicial'
      )
    end
  end
end
