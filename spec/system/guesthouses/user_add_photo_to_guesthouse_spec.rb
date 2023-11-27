require 'rails_helper'

describe 'User adds photos to their guesthouse' do
  it 'from the guesthouse details page' do
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

    # Act
    login_as user
    visit root_path
    click_on 'Minha Pousada'
    click_on 'Editar'

    # Assert
    expect(page).to have_field 'Adicionar foto'
  end

  it 'multiple at once' do
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

    # Act
    login_as user
    visit edit_guesthouse_path(guesthouse.id)
    attach_file('guesthouse[pictures][]',
                [Rails.root.join('spec/dummy_files/dummy.jpg'),
                 Rails.root.join('spec/dummy_files/dummy.png')])
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Pousada atualizada com sucesso'
    expect(guesthouse.pictures.size).to eq 2
  end

  it 'and can only upload JPEG and PNG' do
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

    # Act
    login_as user
    visit edit_guesthouse_path(guesthouse.id)
    attach_file('guesthouse[pictures][]',
                Rails.root.join('spec/dummy_files/dummy.txt'))
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Fotos devem ser em formato JPEG ou PNG'
    expect(guesthouse.pictures.size).to eq 0
  end

  it 'and can add more' do
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
                      filename: 'dummy.png',
                      content_type: 'image/png')
    guesthouse.save

    # Act
    login_as user
    visit edit_guesthouse_path(guesthouse.id)
    attach_file('guesthouse[pictures][]',
                Rails.root.join('spec/dummy_files/dummy.jpg'))
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Pousada atualizada com sucesso'
    expect(guesthouse.reload.pictures.size).to eq 2
  end
end
