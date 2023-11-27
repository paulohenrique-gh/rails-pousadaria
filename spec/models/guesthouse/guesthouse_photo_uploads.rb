require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  context '#valid' do
    it 'returns false when file type is not JPEG' do
      # Arrange
      user = User.create!(email: 'exemplo@mail.com', password: 'password')

      address = Address.create!(street_name: 'Rua das Pedras', number: '30',
                                neighbourhood: 'Santa Helena',
                                city: 'Pulomiranga', state: 'RN',
                                postal_code: '99000-525')

      guesthouse = Guesthouse.create!(brand_name: 'Pousada Bosque',
                                      corporate_name: 'Pousada Ramos Faria LTDA',
                                      registration_number: '02303221000152',
                                      phone_number: '1130205456',
                                      email: 'atendimento@pousadabosque',
                                      checkin_time: '08:00', checkout_time: '18:00',
                                      address: address, user: user)

      guesthouse.pictures
                .attach(io:File.open('spec/dummy_files/dummy.png'),
                        filename: 'dummy.png',
                        content_type: 'image/png')
      guesthouse.save

      # Act
      guesthouse.pictures
                .attach(io:File.open('spec/dummy_files/dummy.txt'),
                        filename: 'dummy.txt',
                        content_type: 'text/plain')

      # Assert
      expect(guesthouse).not_to be_valid
    end
  end
end
