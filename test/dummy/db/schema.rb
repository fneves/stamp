# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131103141810) do

  create_table "stamp_pre_reservations", force: true do |t|
    t.integer  "customer_id"
    t.integer  "time_slot_id"
    t.integer  "service_id"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_price_ratings", force: true do |t|
    t.integer  "service_id"
    t.datetime "from"
    t.datetime "to"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_rate_types", force: true do |t|
    t.string   "description"
    t.string   "period_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_reservations", force: true do |t|
    t.integer  "customer_id"
    t.integer  "time_slot_id"
    t.integer  "service_id"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_service_types", force: true do |t|
    t.string   "name"
    t.integer  "rate_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_services", force: true do |t|
    t.string   "name"
    t.integer  "service_type_id"
    t.string   "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamp_time_slots", force: true do |t|
    t.integer  "reservation_id"
    t.integer  "service_id"
    t.datetime "from"
    t.integer  "unit"
    t.integer  "rate_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
