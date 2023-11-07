# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#


1.upto(10) do |i|
  user = User.create!(email: "usuario#{i}@mail.com", password: 'password')
  address = Address.create!(
    street_name: "Rua #{i}",
    number: "#{i.to_s * 3}",
    complement: 'Térreo',
    neighbourhood: "Conjunto #{i}",
    city: "Cidade #{i}",
    state: 'CE',
    postal_code: "#{i.to_s * 8}",
  )
  guesthouse = Guesthouse.create!(
    brand_name: "Pousada #{i}",
    corporate_name: "Pousadas #{i} LTDA",
    registration_number: "#{i.to_s * 15}",
    phone_number: "#{i.to_s * 10}",
    email: "pousada#{i}@mail.com",
    description: 'Pousada próxima à Beira-Mar',
    pet_policy: true,
    guesthouse_policy: 'Proibido som alto',
    checkin_time: '08:30',
    checkout_time: '18:00',
    payment_method_one: 'Dinheiro',
    payment_method_two: 'Pix',
    payment_method_three: 'Cartão',
    user: user,
    address: address
  )
  room_one = Room.create!(
    name: "Quarto #{i}",
    description: "Quarto com tema #{i}",
    dimension: i * 100,
    max_people: i * 2,
    daily_rate: i * 150,
    private_bathroom: true,
    balcony: false,
    air_conditioning: true,
    tv: true,
    closet: false,
    safe: false,
    accessibility: false,
    available: true,
    guesthouse: guesthouse
  )
  SeasonalRate.create!(
    start_date: "2024-12-24",
    finish_date: "2025-01-01",
    rate: i * 300,
    room: room_one
  )
  SeasonalRate.create!(
    start_date: "2025-02-01",
    finish_date: "2025-02-15",
    rate: i * 500,
    room: room_one
  )
  room_two = Room.create!(
    name: "Quarto #{i + 1}",
    description: "Quarto com tema #{i + 1}",
    dimension: i * 50,
    max_people: i * 2,
    daily_rate: i * 40,
    private_bathroom: true,
    balcony: false,
    air_conditioning: false,
    tv: true,
    closet: true,
    safe: false,
    accessibility: true,
    available: true,
    guesthouse: guesthouse
  )
  SeasonalRate.create!(
    start_date: "2024-12-24",
    finish_date: "2025-01-01",
    rate: 750,
    room: room_two
  )
  SeasonalRate.create!(
    start_date: "2025-02-01",
    finish_date: "2025-02-15",
    rate: 900,
    room: room_two
  )
end
