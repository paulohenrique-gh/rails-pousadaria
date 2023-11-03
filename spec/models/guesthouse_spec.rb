require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '#valid?' do
    it 'returns false when brand_name is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: '',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when corporate_name is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: '',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when registration_number is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when phone_number is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when email is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: '',
                                     address: address, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when address is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: nil, user: user)

      expect(guesthouse).not_to be_valid
    end

    it 'returns false when user is empty' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: nil)

      expect(guesthouse).not_to be_valid
    end

    it 'returns true when all required arguments are given' do
      user = User.create!(email: 'exemplo@mail.com', password: 'password')
      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create(brand_name: 'Pousada Bosque',
                                     corporate_name: 'Pousada Ramos Faria LTDA',
                                     registration_number: '02303221000152',
                                     phone_number: '1130205000',
                                     email: 'atendimento@pousadabosque',
                                     address: address, user: user)

      expect(guesthouse).to be_valid
    end
  end
end
