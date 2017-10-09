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

ActiveRecord::Schema.define(version: 20170423191416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_calls", force: :cascade do |t|
    t.string   "source"
    t.text     "url"
    t.integer  "response_code"
    t.text     "response"
    t.integer  "response_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image_url"
    t.integer  "points"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "google_achievement_id"
    t.string   "uuid"
  end

  add_index "badges", ["uuid"], name: "index_badges_on_uuid", unique: true, using: :btree

  create_table "journey_legs", force: :cascade do |t|
    t.integer  "journey_id"
    t.integer  "departure_station_id", null: false
    t.integer  "arrival_station_id",   null: false
    t.datetime "scheduled_departure"
    t.datetime "scheduled_arrival"
    t.datetime "actual_departure"
    t.datetime "actual_arrival"
    t.string   "departure_platform"
    t.string   "arrival_platform"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "operator_id"
    t.string   "uuid"
  end

  add_index "journey_legs", ["journey_id"], name: "index_journey_legs_on_journey_id", using: :btree
  add_index "journey_legs", ["uuid"], name: "index_journey_legs_on_uuid", unique: true, using: :btree

  create_table "journeys", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uuid"
  end

  add_index "journeys", ["user_id"], name: "index_journeys_on_user_id", using: :btree
  add_index "journeys", ["uuid"], name: "index_journeys_on_uuid", unique: true, using: :btree

  create_table "operators", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "twitter"
    t.string   "delay_repay_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "numeric_code"
    t.string   "uuid"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
  end

  add_index "operators", ["uuid"], name: "index_operators_on_uuid", unique: true, using: :btree

  create_table "ppms", force: :cascade do |t|
    t.integer  "operator_id"
    t.integer  "ppm"
    t.integer  "on_time"
    t.integer  "late"
    t.integer  "cancel_very_late"
    t.integer  "total"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
  end

  add_index "ppms", ["operator_id"], name: "index_ppms_on_operator_id", using: :btree

  create_table "reasons", force: :cascade do |t|
    t.string   "code"
    t.string   "uuid"
    t.text     "late_running_reason"
    t.text     "cancellation_reason"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "reasons", ["uuid", "code"], name: "index_reasons_on_uuid_and_code", using: :btree

  create_table "station_tube_lines", id: false, force: :cascade do |t|
    t.integer "tube_line_id"
    t.integer "id"
    t.integer "running_time"
    t.integer "distance"
    t.integer "from_id"
    t.integer "to_id"
    t.string  "direction"
  end

  add_index "station_tube_lines", ["id"], name: "index_station_tube_lines_on_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.string   "crs"
    t.decimal  "lat",                precision: 10, scale: 7
    t.decimal  "lng",                precision: 10, scale: 7
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "number"
    t.text     "facilities"
    t.string   "phone"
    t.string   "address"
    t.string   "underground_zones"
    t.boolean  "underground"
    t.string   "underground_code"
    t.string   "uuid"
    t.boolean  "national_rail"
    t.string   "twitter"
    t.integer  "operator_id"
    t.string   "rail_naptan"
    t.string   "underground_naptan"
  end

  add_index "stations", ["number"], name: "index_stations_on_number", using: :btree
  add_index "stations", ["rail_naptan"], name: "index_stations_on_rail_naptan", using: :btree
  add_index "stations", ["underground_naptan"], name: "index_stations_on_underground_naptan", using: :btree
  add_index "stations", ["uuid"], name: "index_stations_on_uuid", unique: true, using: :btree

  create_table "timetable_calling_points", force: :cascade do |t|
    t.integer  "timetable_id"
    t.string   "calling_point_type"
    t.boolean  "cancelled"
    t.string   "tiploc_code"
    t.integer  "timing_point_id"
    t.integer  "station_id"
    t.string   "public_time_arrival"
    t.string   "public_time_departure"
    t.string   "working_time_arrival"
    t.string   "working_time_departure"
    t.string   "working_time_passing"
    t.string   "platform"
    t.text     "activities"
    t.text     "planned_activities"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "timetable_calling_points", ["station_id"], name: "index_timetable_calling_points_on_station_id", using: :btree
  add_index "timetable_calling_points", ["timetable_id"], name: "index_timetable_calling_points_on_timetable_id", using: :btree
  add_index "timetable_calling_points", ["timing_point_id"], name: "index_timetable_calling_points_on_timing_point_id", using: :btree

  create_table "timetables", force: :cascade do |t|
    t.string   "rtti_id"
    t.string   "uuid"
    t.integer  "operator_id"
    t.string   "train_id"
    t.string   "schedule_id"
    t.date     "start_date"
    t.string   "train_type"
    t.string   "train_category"
    t.text     "late_running_reason"
    t.text     "cancellation_reason"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "timetables", ["uuid"], name: "index_timetables_on_uuid", using: :btree

  create_table "timing_points", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "uuid"
    t.integer  "station_id"
    t.decimal  "lat",        precision: 10, scale: 7
    t.decimal  "lng",        precision: 10, scale: 7
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stanox"
  end

  add_index "timing_points", ["code", "uuid", "station_id"], name: "index_timing_points_on_code_and_uuid_and_station_id", using: :btree
  add_index "timing_points", ["stanox"], name: "index_timing_points_on_stanox", using: :btree

  create_table "tube_lines", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "number"
    t.string   "background_colour"
    t.string   "text_colour"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "uuid"
  end

  add_index "tube_lines", ["code", "number"], name: "index_tube_lines_on_code_and_number", using: :btree
  add_index "tube_lines", ["uuid"], name: "index_tube_lines_on_uuid", unique: true, using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_favourite_stations", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "station_id", null: false
  end

  add_index "user_favourite_stations", ["station_id", "user_id"], name: "index_user_favourite_stations_on_station_id_and_user_id", using: :btree
  add_index "user_favourite_stations", ["user_id", "station_id"], name: "index_user_favourite_stations_on_user_id_and_station_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "home_station_id"
    t.integer  "work_station_id"
    t.string   "uuid"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["home_station_id"], name: "index_users_on_home_station_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree
  add_index "users", ["work_station_id"], name: "index_users_on_work_station_id", using: :btree

  add_foreign_key "journey_legs", "journeys"
  add_foreign_key "journey_legs", "operators"
  add_foreign_key "journeys", "users"
  add_foreign_key "ppms", "operators"
end
