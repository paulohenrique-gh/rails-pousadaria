require 'rails_helper'

describe 'User deletes guesthouse picture' do
  it 'and is not authenticated' do
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
    delete(delete_picture_guesthouse_path(guesthouse.id),
           params: { picture_id: guesthouse.pictures.last.id })

    # Assert
    expect(response).to redirect_to new_user_session_path
    expect(guesthouse.reload.pictures.size).to eq 1
  end

  it 'and is not the owner' do
    # Arrange
    user = User.create!(email: 'exemplo@mail.com', password: 'password')
    other_user = User.create!(email: 'outro@mail.com', password: 'password')

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
    login_as other_user
    delete(delete_picture_guesthouse_path(guesthouse.id),
           params: { picture_id: guesthouse.pictures.last.id } )

    # Assert
    expect(response).to redirect_to root_path
    expect(guesthouse.reload.pictures.size).to be 1
  end
end
