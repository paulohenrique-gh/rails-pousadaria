require 'rails_helper'

describe 'User removes guesthouse photo' do
  it 'successfully' do
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
                                    checkin_time: '08:00',
                                    checkout_time: '18:00',
                                    address: address, user: user)

    guesthouse.pictures
              .attach(io: File.open('spec/dummy_files/dummy.png'),
                      filename: 'dummy.png', content_type: 'image/png')
    guesthouse.save

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    within '.guesthouse-photos' do
      click_on 'Excluir'
    end

    expect(guesthouse.reload.pictures.attached?).to be false
  end
end
