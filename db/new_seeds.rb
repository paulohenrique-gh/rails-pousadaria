guest_one = Guest.create!(name: 'Paulo Bastos', document: '555202555-99',
                          email: 'paulo@mail.com', password: 'password')

guest_two = Guest.create!(name: 'Ana Silva', document: '123456789-01',
                          email: 'ana@mail.com', password: 'password')

guest_three = Guest.create!(name: 'Lucas Santos', document: '987654321-00',
                            email: 'lucas@mail.com', password: 'password')

guest_four = Guest.create!(name: 'Isabela Oliveira', document: '456789123-45',
                           email: 'isabela@mail.com', password: 'password')

guest_five = Guest.create!(name: 'Ricardo Pereira', document: '112233445-67',
                           email: 'ricardo@mail.com', password: 'password')

guest_six = Guest.create!(name: 'Camila Souza', document: '987654321-98',
                          email: 'camila@mail.com', password: 'password')

guest_seven = Guest.create!(name: 'Diego Lima', document: '111222333-44',
                            email: 'diego@mail.com', password: 'password')

guest_eight = Guest.create!(name: 'Fernanda Costa', document: '555444333-22',
                            email: 'fernanda@mail.com', password: 'password')

guest_nine = Guest.create!(name: 'Pedro Alves', document: '777888999-00',
                           email: 'pedro@mail.com', password: 'password')

guest_ten = Guest.create!(name: 'Juliana Rocha', document: '112233445-56',
                          email: 'juliana@mail.com', password: 'password')

user_one = User.create!(email: 'riocalmo@mail.com', password: 'password')

user_two = User.create!(email: 'paulista@mail.com', password: 'password')

user_three = User.create!(email: 'cearacharme@mail.com', password: 'password')

user_four = User.create!(email: 'praia@mail.com', password: 'password')

user_five = User.create!(email: 'sossego@mail.com', password: 'password')

user_six = User.create!(email: 'charme@mail.com', password: 'password')

user_seven = User.create!(email: 'tropical@mail.com', password: 'password')

user_eight = User.create!(email: 'montanhas@mail.com', password: 'password')

user_nine = User.create!(email: 'encanto@mail.com', password: 'password')

user_ten = User.create!(email: 'sol@mail.com', password: 'password')


address_one = Address.create!(stree_name: 'Rua Santo Amaro', number: '455',
                              neighbourhood: 'Parque Dois Irmãos',
                              city: 'Salvador', state: 'BA', postal_code: '75000-525')

address_two = Address.create!(street_name: 'Avenida Paulista', number: '123',
                              neighbourhood: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', postal_code: '01310-000')

address_three = Address.create!(street_name: 'Rua dos Bandeirantes', number: '789',
                                complement: 'Térreo', neighbourhood: 'Vila Madalena',
                                city: 'São Paulo', state: 'SP', postal_code: '05415-001')

address_four = Address.create!(street_name: 'Avenida Beira Mar', number: '567',
                               neighbourhood: 'Meireles',
                               city: 'Fortaleza', state: 'CE', postal_code: '60165-120')

address_five = Address.create!(street_name: 'Travessa da Lapa', number: '987',
                               neighbourhood: 'Lapa',
                               city: 'Rio de Janeiro', state: 'RJ', postal_code: '20021-315')

address_six = Address.create!(street_name: 'Rua das Flores', number: '321',
                              neighbourhood: 'Jardim Botânico',
                              city: 'Curitiba', state: 'PR', postal_code: '80210-000')

address_seven = Address.create!(street_name: 'Avenida Atlântica', number: '654',
                                neighbourhood: 'Copacabana',
                                city: 'Rio de Janeiro', state: 'RJ', postal_code: '22010-000')

address_eight = Address.create!(street_name: 'Rua da Paz', number: '876',
                                neighbourhood: 'Centro',
                                city: 'Belo Horizonte', state: 'MG', postal_code: '30180-090')

address_nine = Address.create!(street_name: 'Avenida das Palmeiras', number: '234',
                               neighbourhood: 'Jardim das Palmeiras',
                               city: 'Recife', state: 'PE', postal_code: '52021-030')

address_ten = Address.create!(street_name: 'Rua das Orquídeas', number: '543',
                              neighbourhood: 'Jardim Botânico',
                              city: 'Porto Alegre', state: 'RS', postal_code: '90035-120')


guesthouse_one = Guesthouse.create!(brand_name: 'Pousada Rio Calmo',
                                    corporate_name: 'DDT Hotelaria LTDA',
                                    registration_number: '02.225.658/0001-20',
                                    phone_number: '7132226555',
                                    email: 'atendimento@riocalmo.com',
                                    description: 'Eleita melhor pousada do Parque Dois Irmãos',
                                    pet_policy: true,
                                    guesthouse_policy: 'Proibido uso de bebidas alcoólicas e som alto',
                                    checkin_time: '14:00', checkout_time: '11:00',
                                    payment_method_one: 'Cartão de crédito',
                                    payment_method_two: 'Pix', address: address_one,
                                    user: user_one)

guesthouse_two = Guesthouse.create!(brand_name: 'Pousada Paulista',
                                    corporate_name: 'ABC Hospedagem LTDA',
                                    registration_number: '12.345.678/0001-90',
                                    phone_number: '1133334444',
                                    email: 'reservas@pousadapaulista.com',
                                    description: 'Conforto e tranquilidade na Avenida Paulista',
                                    pet_policy: true,
                                    guesthouse_policy: 'Área de fumantes disponível',
                                    checkin_time: '15:00', checkout_time: '12:00',
                                    payment_method_one: 'Boleto bancário',
                                    payment_method_two: 'Transferência bancária', address: address_two,
                                    user: user_two)

guesthouse_three = Guesthouse.create!(brand_name: 'Pousada Ceará Charme',
                                      corporate_name: 'XYZ Turismo LTDA',
                                      registration_number: '98.765.432/0001-50',
                                      phone_number: '8533332222',
                                      email: 'reservas@cearacharme.com',
                                      description: 'Descubra o charme do litoral cearense',
                                      pet_policy: false,
                                      guesthouse_policy: 'Estacionamento gratuito para hóspedes',
                                      checkin_time: '14:30', checkout_time: '11:30',
                                      payment_method_one: 'Dinheiro',
                                      payment_method_two: 'Cartão de débito', address: address_three,
                                      user: user_three)

guesthouse_four = Guesthouse.create!(brand_name: 'Pousada da Praia',
                                     corporate_name: 'LMN Hospedagem LTDA',
                                     registration_number: '45.678.901/0001-23',
                                     phone_number: '8533331111',
                                     email: 'contato@pousadadapraia.com',
                                     description: 'Seu refúgio à beira-mar',
                                     pet_policy: true,
                                     guesthouse_policy: 'Café da manhã incluso',
                                     checkin_time: '16:00', checkout_time: '12:00',
                                     payment_method_one: 'Cartão de crédito',
                                     payment_method_two: 'PicPay', address: address_four,
                                     user: user_four)

guesthouse_five = Guesthouse.create!(brand_name: 'Pousada do Sossego',
                                     corporate_name: 'OPQ Turismo LTDA',
                                     registration_number: '01.234.567/0001-34',
                                     phone_number: '8133335555',
                                     email: 'reservas@sossegopousada.com',
                                     description: 'Relaxe e aproveite o sossego da natureza',
                                     pet_policy: false,
                                     guesthouse_policy: 'Wi-Fi grátis em todas as áreas',
                                     checkin_time: '15:00', checkout_time: '11:00',
                                     payment_method_one: 'Transferência bancária',
                                     payment_method_two: 'Boleto bancário', address: address_five,
                                     user: user_five)

guesthouse_six = Guesthouse.create!(brand_name: 'Pousada Charme Urbano',
                                    corporate_name: 'EFG Hospedagem LTDA',
                                    registration_number: '87.654.321/0001-12',
                                    phone_number: '4133337777',
                                    email: 'contato@charmeurbano.com',
                                    description: 'Elegância no coração da cidade',
                                    pet_policy: true,
                                    guesthouse_policy: 'Piscina e academia disponíveis',
                                    checkin_time: '14:00', checkout_time: '12:30',
                                    payment_method_one: 'Pix',
                                    payment_method_two: 'Dinheiro', address: address_six,
                                    user: user_six)

guesthouse_seven = Guesthouse.create!(brand_name: 'Pousada Tropical',
                                      corporate_name: 'HIJ Turismo LTDA',
                                      registration_number: '67.890.123/0001-45',
                                      phone_number: '8533338888',
                                      email: 'reservas@tropicalpousada.com',
                                      description: 'Ambiente tropical para suas férias',
                                      pet_policy: false,
                                      guesthouse_policy: 'Check-in antecipado mediante disponibilidade',
                                      checkin_time: '14:30', checkout_time: '11:30',
                                      payment_method_one: 'Cartão de débito',
                                      payment_method_two: 'Transferência bancária', address: address_seven,
                                      user: user_seven)

guesthouse_eight = Guesthouse.create!(brand_name: 'Pousada das Montanhas',
                                      corporate_name: 'LMN Hospedagem Serra LTDA',
                                      registration_number: '23.456.789/0001-56',
                                      phone_number: '4733339999',
                                      email: 'reservas@montanhaspousada.com',
                                      description: 'Vistas deslumbrantes e tranquilidade nas montanhas',
                                      pet_policy: true,
                                      guesthouse_policy: 'Restaurante interno com culinária regional',
                                      checkin_time: '16:00', checkout_time: '12:00',
                                      payment_method_one: 'Cartão de crédito',
                                      payment_method_two: 'PicPay', address: address_eight,
                                      user: user_eight)

guesthouse_nine = Guesthouse.create!(brand_name: 'Pousada Encanto Verde',
                                     corporate_name: 'XYZ Hospedagem Ecológica LTDA',
                                     registration_number: '78.901.234/0001-78',
                                     phone_number: '8133333333',
                                     email: 'reservas@encantoverde.com',
                                     description: 'Sustentabilidade e conforto em harmonia',
                                     pet_policy: false,
                                     guesthouse_policy: 'Atividades de ecoturismo disponíveis',
                                     checkin_time: '15:00', checkout_time: '11:00',
                                     payment_method_one: 'Transferência bancária',
                                     payment_method_two: 'Boleto bancário', address: address_nine,
                                     user: user_nine)

guesthouse_ten = Guesthouse.create!(brand_name: 'Pousada do Sol',
                                    corporate_name: 'ABC Hospedagem Solar LTDA',
                                    registration_number: '45.678.901/0001-23',
                                    phone_number: '5533336666',
                                    email: 'reservas@dossolpousada.com',
                                    description: 'Aproveite o pôr do sol em grande estilo',
                                    pet_policy: true,
                                    guesthouse_policy: 'Estacionamento privativo gratuito',
                                    checkin_time: '14:00', checkout_time: '12:30',
                                    payment_method_one: 'Pix',
                                    payment_method_two: 'Dinheiro', address: address_ten,
                                    user: user_ten)

room_one_guesthouse_one = Room.create!(name: 'Nordeste',
                                       description: 'Quarto com tema rústico nordestino',
                                       dimension: 245, max_people: 5, daily_rate: 250,
                                       private_bathroom: true, balcony: false,
                                       air_conditioning: false, tv: true,
                                       closet: true, safe: false, accessibility: true,
                                       guesthouse: guesthouse_one)

room_two_guesthouse_one = Room.create!(name: 'Litoral',
                                       description: 'Quarto com vista para o mar',
                                       dimension: 200, max_people: 4, daily_rate: 200,
                                       private_bathroom: true, balcony: true,
                                       air_conditioning: true, tv: true,
                                       closet: false, safe: true, accessibility: false,
                                       guesthouse: guesthouse_one)

room_one_guesthouse_two = Room.create!(name: 'Metropolitano',
                                       description: 'Quarto moderno no coração da cidade',
                                       dimension: 220, max_people: 4, daily_rate: 280,
                                       private_bathroom: true, balcony: true,
                                       air_conditioning: true, tv: true,
                                       closet: false, safe: true, accessibility: false,
                                       guesthouse: guesthouse_two)

room_two_guesthouse_two = Room.create!(name: 'Retiro Tranquilo',
                                       description: 'Quarto com atmosfera relaxante',
                                       dimension: 180, max_people: 3, daily_rate: 220,
                                       private_bathroom: true, balcony: false,
                                       air_conditioning: true, tv: false,
                                       closet: true, safe: false, accessibility: true,
                                       guesthouse: guesthouse_two)

room_one_guesthouse_three = Room.create!(name: 'Praiano',
                                         description: 'Quarto com vista para o mar',
                                         dimension: 210, max_people: 3, daily_rate: 230,
                                         private_bathroom: true, balcony: true,
                                         air_conditioning: true, tv: true,
                                         closet: false, safe: true, accessibility: false,
                                         guesthouse: guesthouse_three)

room_two_guesthouse_three = Room.create!(name: 'Campestre',
                                         description: 'Quarto com decoração rural',
                                         dimension: 190, max_people: 4, daily_rate: 200,
                                         private_bathroom: true, balcony: false,
                                         air_conditioning: false, tv: true,
                                         closet: true, safe: false, accessibility: true,
                                         guesthouse: guesthouse_three)

room_one_guesthouse_four = Room.create!(name: 'Marítimo',
                                        description: 'Quarto com decoração náutica',
                                        dimension: 220, max_people: 4, daily_rate: 250,
                                        private_bathroom: true, balcony: true,
                                        air_conditioning: true, tv: true,
                                        closet: false, safe: true, accessibility: false,
                                        guesthouse: guesthouse_four)

room_two_guesthouse_four = Room.create!(name: 'Sossegado',
                                        description: 'Quarto para relaxamento total',
                                        dimension: 200, max_people: 3, daily_rate: 220,
                                        private_bathroom: true, balcony: false,
                                        air_conditioning: true, tv: false,
                                        closet: true, safe: false, accessibility: true,
                                        guesthouse: guesthouse_four)

room_one_guesthouse_five = Room.create!(name: 'Estados Unidos',
                                        description: 'Quarto com tema americano moderno',
                                        dimension: 210, max_people: 3, daily_rate: 220,
                                        private_bathroom: true, balcony: true,
                                        air_conditioning: false, tv: true,
                                        closet: false, safe: true, accessibility: true,
                                        guesthouse: guesthouse_five)

room_two_guesthouse_five = Room.create!(name: 'Espanha',
                                        description: 'Quarto com aromas e trilha sonora espanhola',
                                        dimension: 190, max_people: 4, daily_rate: 240,
                                        private_bathroom: true, balcony: false,
                                        air_conditioning: true, tv: true,
                                        closet: true, safe: false, accessibility: true,
                                        guesthouse: guesthouse_five)


room_one_guesthouse_six = Room.create!(name: 'Urbano',
                                       description: 'Quarto de luxo no centro urbano',
                                       dimension: 220, max_people: 4, daily_rate: 300,
                                       private_bathroom: true, balcony: true,
                                       air_conditioning: true, tv: true,
                                       closet: false, safe: true, accessibility: false,
                                       guesthouse: guesthouse_six)

room_two_guesthouse_six = Room.create!(name: 'Tranquilidade Urbana',
                                       description: 'Quarto com atmosfera relaxante',
                                       dimension: 200, max_people: 3, daily_rate: 250,
                                       private_bathroom: true, balcony: false,
                                       air_conditioning: true, tv: false,
                                       closet: true, safe: false, accessibility: true,
                                       guesthouse: guesthouse_six)

room_one_guesthouse_seven = Room.create!(name: 'Final Fantasy',
                                         description: 'Suíte luxuosa com tema Final Fantasy',
                                         dimension: 210, max_people: 3, daily_rate: 280,
                                         private_bathroom: true, balcony: true,
                                         air_conditioning: true, tv: true,
                                         closet: false, safe: true, accessibility: false,
                                         guesthouse: guesthouse_seven)

room_two_guesthouse_seven = Room.create!(name: 'Donkey Kong',
                                         description: 'Quarto confortável com tema Donkey Kong',
                                         dimension: 190, max_people: 4, daily_rate: 250,
                                         private_bathroom: true, balcony: false,
                                         air_conditioning: false, tv: true,
                                         closet: true, safe: false, accessibility: true,
                                         guesthouse: guesthouse_seven)


room_one_guesthouse_eight = Room.create!(name: 'Montanha',
                                         description: 'Quarto com vista panorâmica',
                                         dimension: 220, max_people: 4, daily_rate: 300,
                                         private_bathroom: true, balcony: true,
                                         air_conditioning: true, tv: true,
                                         closet: false, safe: true, accessibility: false,
                                         guesthouse: guesthouse_eight)

room_two_guesthouse_eight = Room.create!(name: 'Refúgio Rural',
                                         description: 'Quarto com atmosfera rural',
                                         dimension: 200, max_people: 3, daily_rate: 260,
                                         private_bathroom: true, balcony: false,
                                         air_conditioning: true, tv: false,
                                         closet: true, safe: false, accessibility: true,
                                         guesthouse: guesthouse_eight)


room_one_guesthouse_nine = Room.create!(name: 'Pop Star',
                                        description: 'Suíte luxuosa inspirada nas estrelas pop',
                                        dimension: 210, max_people: 3, daily_rate: 280,
                                        private_bathroom: true, balcony: true,
                                        air_conditioning: true, tv: true,
                                        closet: false, safe: true, accessibility: false,
                                        guesthouse: guesthouse_nine)

room_two_guesthouse_nine = Room.create!(name: 'Cores',
                                        description: 'Quarto com harmonia de cores',
                                        dimension: 190, max_people: 4, daily_rate: 250,
                                        private_bathroom: true, balcony: false,
                                        air_conditioning: false, tv: true,
                                        closet: true, safe: false, accessibility: true,
                                        guesthouse: guesthouse_nine)


room_one_guesthouse_ten = Room.create!(name: 'Anos 80',
                                       description: 'Suíte de luxo com tema anos 80',
                                       dimension: 220, max_people: 4, daily_rate: 300,
                                       private_bathroom: true, balcony: true,
                                       air_conditioning: true, tv: true,
                                       closet: false, safe: true, accessibility: false,
                                       guesthouse: guesthouse_ten)

room_two_guesthouse_ten = Room.create!(name: 'Anos 90',
                                       description: 'Quarto nostálgico com tema anos 90',
                                       dimension: 200, max_people: 3, daily_rate: 260,
                                       private_bathroom: true, balcony: false,
                                       air_conditioning: true, tv: false,
                                       closet: true, safe: false, accessibility: true,
                                       guesthouse: guesthouse_ten)


seasonal_rate_one = SeasonalRate.create!(start_date: 10.days.ago,
                                         finish_date: 20.days.from_now,
                                         rate: 450, room: room_one_guesthouse_eight)

seasonal_rate_two = SeasonalRate.create!(start_date: 15.days.from_now,
                                         finish_date: 25.days.from_now,
                                         rate: 380, room: room_two_guesthouse_nine)

seasonal_rate_three = SeasonalRate.create!(start_date: 5.days.from_now,
                                           finish_date: 15.days.from_now,
                                           rate: 300, room: room_one_guesthouse_ten)

seasonal_rate_four = SeasonalRate.create!(start_date: 16.days.from_now,
                                          finish_date: 21.days.from_now,
                                          rate: 320, room: room_one_guesthouse_ten)

seasonal_rate_five = SeasonalRate.create!(start_date: 25.days.from_now,
                                          finish_date: 35.days.from_now,
                                          rate: 400, room: room_two_guesthouse_eight)


reservation_one = Reservation.new(checkin: 2.days.ago, checkout: 15.days.from_now,
                                  guest_count: 3, stay_total: 5040,
                                  room: room_one_guesthouse_two, guest: guest_three,
                                  status: :guests_checked_in,
                                  checked_in_at: 1.day.ago)
reservation_one.save(validate: false)

reservation_two = Reservation.new(checkin: 2.days.ago, checkout: 15.days.from_now,
                                  guest_count: 3, stay_total: 5040,
                                  room: room_one_guesthouse_four, guest: guest_five,
                                  status: :guests_checked_in,
                                  checked_in_at: 1.day.ago)
reservation_two.save(validate: false)

reservation_three = Reservation.new(checkin: 5.days.from_now, checkout: 20.days.from_now,
                                  guest_count: 2, stay_total: 3000,
                                  room: room_two_guesthouse_three, guest: guest_one,
                                  status: :confirmed)
reservation_three.save

reservation_four = Reservation.new(checkin: 10.days.ago, checkout: 5.days.ago,
                                    guest_count: 1, stay_total: 1200,
                                    room: room_one_guesthouse_one, guest: guest_two,
                                    status: :guests_checked_out,
                                    checked_in_at: 9.days.ago,
                                    checked_out_at: 5.days.ago,
                                    payment_method: 'Cartão de crédito')
reservation_four.save(validate: false)
