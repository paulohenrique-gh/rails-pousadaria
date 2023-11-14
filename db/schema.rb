# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_13_232317) do
  create_table "addresses", force: :cascade do |t|
    t.string "street_name", null: false
    t.string "number", null: false
    t.string "complement"
    t.string "neighbourhood", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guesthouses", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.text "description"
    t.boolean "pet_policy"
    t.text "guesthouse_policy"
    t.time "checkin_time"
    t.time "checkout_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method_one"
    t.string "payment_method_two"
    t.string "payment_method_three"
    t.integer "user_id", null: false
    t.integer "address_id", null: false
    t.integer "status", default: 0
    t.index ["address_id"], name: "index_guesthouses_on_address_id"
    t.index ["user_id"], name: "index_guesthouses_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "checkin", null: false
    t.date "checkout", null: false
    t.integer "guest_count", null: false
    t.float "stay_total", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "dimension"
    t.integer "max_people"
    t.float "daily_rate"
    t.boolean "private_bathroom", default: false
    t.boolean "balcony", default: false
    t.boolean "air_conditioning", default: false
    t.boolean "tv", default: false
    t.boolean "closet", default: false
    t.boolean "safe", default: false
    t.boolean "accessibility", default: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guesthouse_id", null: false
    t.index ["guesthouse_id"], name: "index_rooms_on_guesthouse_id"
  end

  create_table "seasonal_rates", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "finish_date", null: false
    t.float "rate", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["room_id"], name: "index_seasonal_rates_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "guesthouses", "addresses"
  add_foreign_key "guesthouses", "users"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "rooms", "guesthouses"
  add_foreign_key "seasonal_rates", "rooms"
end
