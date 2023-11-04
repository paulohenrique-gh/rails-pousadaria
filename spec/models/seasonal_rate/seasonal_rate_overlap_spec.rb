require 'rails_helper'

RSpec.describe SeasonalRate, type: :model do
  describe '#check_overlap_in_dates' do
    it 'adds start_date and finish_date errors' do
      # Arrange
      seasonal_rate = SeasonalRate.new(start_date: '2023-12-01',
                                       finish_date: '2023-12-31')
      other_seasonal_rate = SeasonalRate.new(start_date: '2023-12-24',
                                             finish_date: '2023-12-30')

      # Act
      other_seasonal_rate.send(:check_overlap_in_dates, seasonal_rate)

      # Assert
      expect(other_seasonal_rate.errors.include? :start_date).to be true
      expect(other_seasonal_rate.errors.include? :finish_date).to be true
      expect(other_seasonal_rate.errors[:start_date]).to include(
        'dentro de período já cadastrado'
      )
      expect(other_seasonal_rate.errors[:finish_date]).to include(
        'dentro de período já cadastrado'
      )
    end
  end

  describe '#dates_do_not_overlap' do
    it 'adds error when dates overlap with existing seasonal rates' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205000',
                                      email: 'atendimento@pousadabosque',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.create!(start_date: '2023-12-01',
                                           finish_date: '2023-12-31',
                                           rate: 200, room: room)
      other_seasonal_rate = SeasonalRate.new(start_date: '2023-12-24',
                                             finish_date: '2023-12-30',
                                             rate: 400, room_id: room.id)

      # Act
      other_seasonal_rate.valid?

      # Assert
      expect(other_seasonal_rate.errors.include? :start_date).to be true
      expect(other_seasonal_rate.errors.include? :finish_date).to be true
      expect(other_seasonal_rate.errors[:start_date]).to include(
        'dentro de período já cadastrado'
      )
      expect(other_seasonal_rate.errors[:finish_date]).to include(
        'dentro de período já cadastrado'
      )
    end

    it "doesn't add error when dates do not overlapp" do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205000',
                                      email: 'atendimento@pousadabosque',
                                      address: address, user: user)

      room = Room.create!(name: 'Brasil', description: 'Quarto com tema Brasil',
                          dimension: 200, max_people: 3, daily_rate: 150,
                          guesthouse: guesthouse)

      seasonal_rate = SeasonalRate.create!(start_date: '2023-12-01',
                                           finish_date: '2023-12-31',
                                           rate: 200, room: room)
      other_seasonal_rate = SeasonalRate.new(start_date: '2023-11-15',
                                             finish_date: '2023-11-20',
                                             rate: 400, room_id: room.id)

      # Act
      other_seasonal_rate.valid?

      # Assert
      expect(other_seasonal_rate.errors.include? :start_date).to be false
      expect(other_seasonal_rate.errors.include? :finish_date).to be false
    end
  end
end
