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

ActiveRecord::Schema.define(version: 20150409203530) do

  create_table "badges", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "description",           limit: 255
    t.string   "image_url",             limit: 255
    t.integer  "points",                limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "google_achievement_id", limit: 255
    t.string   "uuid",                  limit: 255
  end

  add_index "badges", ["uuid"], name: "index_badges_on_uuid", unique: true, using: :btree

  create_table "journey_legs", force: :cascade do |t|
    t.integer  "journey_id",           limit: 4
    t.integer  "departure_station_id", limit: 4,   null: false
    t.integer  "arrival_station_id",   limit: 4,   null: false
    t.datetime "scheduled_departure"
    t.datetime "scheduled_arrival"
    t.datetime "actual_departure"
    t.datetime "actual_arrival"
    t.string   "departure_platform",   limit: 255
    t.string   "arrival_platform",     limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "operator_id",          limit: 4
    t.string   "uuid",                 limit: 255
  end

  add_index "journey_legs", ["journey_id"], name: "index_journey_legs_on_journey_id", using: :btree
  add_index "journey_legs", ["operator_id"], name: "fk_rails_04623ba596", using: :btree
  add_index "journey_legs", ["uuid"], name: "index_journey_legs_on_uuid", unique: true, using: :btree

  create_table "journeys", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uuid",       limit: 255
  end

  add_index "journeys", ["user_id"], name: "index_journeys_on_user_id", using: :btree
  add_index "journeys", ["uuid"], name: "index_journeys_on_uuid", unique: true, using: :btree

  create_table "operators", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "code",            limit: 255
    t.string   "twitter",         limit: 255
    t.string   "delay_repay_url", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "numeric_code",    limit: 255
    t.string   "uuid",            limit: 255
  end

  add_index "operators", ["uuid"], name: "index_operators_on_uuid", unique: true, using: :btree

  create_table "ppms", force: :cascade do |t|
    t.integer  "operator_id",      limit: 4
    t.integer  "ppm",              limit: 4
    t.integer  "on_time",          limit: 4
    t.integer  "late",             limit: 4
    t.integer  "cancel_very_late", limit: 4
    t.integer  "total",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",             limit: 255
  end

  add_index "ppms", ["operator_id"], name: "index_ppms_on_operator_id", using: :btree

  create_table "station_tube_lines", id: false, force: :cascade do |t|
    t.integer "tube_line_id", limit: 4
    t.integer "id",           limit: 4
    t.integer "running_time", limit: 4
    t.integer "distance",     limit: 4
    t.integer "from_id",      limit: 4
    t.integer "to_id",        limit: 4
    t.string  "direction",    limit: 255
  end

  add_index "station_tube_lines", ["id"], name: "index_station_tube_lines_on_id", using: :btree
  add_index "station_tube_lines", ["tube_line_id"], name: "index_station_tube_lines_on_tube_station_id_and_tube_line_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "crs",               limit: 255
    t.decimal  "lat",                             precision: 10, scale: 7
    t.decimal  "lng",                             precision: 10, scale: 7
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "number",            limit: 255
    t.text     "facilities",        limit: 65535
    t.string   "address",           limit: 255
    t.string   "phone",             limit: 255
    t.string   "underground_zones", limit: 255
    t.boolean  "underground",       limit: 1
    t.string   "underground_code",  limit: 255
    t.string   "uuid",              limit: 255
    t.boolean  "national_rail",     limit: 1
    t.string   "twitter",           limit: 255
  end

  add_index "stations", ["number"], name: "index_stations_on_number", using: :btree
  add_index "stations", ["uuid"], name: "index_stations_on_uuid", unique: true, using: :btree

  create_table "tube_lines", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "code",              limit: 255
    t.string   "number",            limit: 255
    t.string   "background_colour", limit: 255
    t.string   "text_colour",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "uuid",              limit: 255
  end

  add_index "tube_lines", ["code", "number"], name: "index_tube_lines_on_code_and_number", using: :btree
  add_index "tube_lines", ["uuid"], name: "index_tube_lines_on_uuid", unique: true, using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "badge_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_favourite_stations", id: false, force: :cascade do |t|
    t.integer "user_id",    limit: 4, null: false
    t.integer "station_id", limit: 4, null: false
  end

  add_index "user_favourite_stations", ["station_id", "user_id"], name: "index_user_favourite_stations_on_station_id_and_user_id", using: :btree
  add_index "user_favourite_stations", ["user_id", "station_id"], name: "index_user_favourite_stations_on_user_id_and_station_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "home_station_id",        limit: 4
    t.integer  "work_station_id",        limit: 4
    t.string   "uuid",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["home_station_id"], name: "index_users_on_home_station_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree
  add_index "users", ["work_station_id"], name: "index_users_on_work_station_id", using: :btree

  add_foreign_key "journey_legs", "journeys"
  add_foreign_key "journey_legs", "operators"
  add_foreign_key "journeys", "users"
  add_foreign_key "ppms", "operators", name: "ppms_ibfk_1"
end
