# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_25_162311) do

  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.float "price_per_day"
    t.string "license_plate"
  end

  create_table "clis", force: :cascade do |t|
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "car_id"
    t.datetime "pickup_date"
    t.datetime "dropoff_date"
    t.integer "trip_duration"
    t.boolean "paid"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "age"
  end

end
