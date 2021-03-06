# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_27_101416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_calls", id: :serial, force: :cascade do |t|
    t.string "source"
    t.text "url"
    t.integer "response_code"
    t.text "response"
    t.integer "response_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image_url"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_achievement_id"
    t.string "uuid"
    t.index ["uuid"], name: "index_badges_on_uuid", unique: true
  end

  create_table "journey_legs", id: :serial, force: :cascade do |t|
    t.integer "journey_id"
    t.integer "departure_station_id", null: false
    t.integer "arrival_station_id", null: false
    t.datetime "scheduled_departure"
    t.datetime "scheduled_arrival"
    t.datetime "actual_departure"
    t.datetime "actual_arrival"
    t.string "departure_platform"
    t.string "arrival_platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operator_id"
    t.string "uuid"
    t.index ["journey_id"], name: "index_journey_legs_on_journey_id"
    t.index ["uuid"], name: "index_journey_legs_on_uuid", unique: true
  end

  create_table "journeys", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["user_id"], name: "index_journeys_on_user_id"
    t.index ["uuid"], name: "index_journeys_on_uuid", unique: true
  end

  create_table "operators", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "twitter"
    t.string "delay_repay_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "numeric_code"
    t.string "uuid"
    t.string "phone"
    t.string "website"
    t.string "email"
    t.index ["uuid"], name: "index_operators_on_uuid", unique: true
  end

  create_table "ppms", id: :serial, force: :cascade do |t|
    t.integer "operator_id"
    t.integer "ppm"
    t.integer "on_time"
    t.integer "late"
    t.integer "cancel_very_late"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["operator_id"], name: "index_ppms_on_operator_id"
  end

  create_table "reasons", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "uuid"
    t.text "late_running_reason"
    t.text "cancellation_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid", "code"], name: "index_reasons_on_uuid_and_code"
  end

  create_table "station_tube_lines", id: false, force: :cascade do |t|
    t.integer "tube_line_id"
    t.integer "id"
    t.integer "running_time"
    t.integer "distance"
    t.integer "from_id"
    t.integer "to_id"
    t.string "direction"
    t.index ["id"], name: "index_station_tube_lines_on_id"
  end

  create_table "stations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "crs"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.text "facilities"
    t.string "phone"
    t.string "address"
    t.string "underground_zones"
    t.boolean "underground"
    t.string "underground_code"
    t.string "uuid"
    t.boolean "national_rail"
    t.string "twitter"
    t.integer "operator_id"
    t.string "rail_naptan"
    t.string "underground_naptan"
    t.index ["number"], name: "index_stations_on_number"
    t.index ["rail_naptan"], name: "index_stations_on_rail_naptan"
    t.index ["underground_naptan"], name: "index_stations_on_underground_naptan"
    t.index ["uuid"], name: "index_stations_on_uuid", unique: true
  end

  create_table "timetable_calling_points", id: :serial, force: :cascade do |t|
    t.integer "timetable_id"
    t.string "calling_point_type"
    t.boolean "cancelled"
    t.string "tiploc_code"
    t.integer "timing_point_id"
    t.integer "station_id"
    t.string "public_time_arrival"
    t.string "public_time_departure"
    t.string "working_time_arrival"
    t.string "working_time_departure"
    t.string "working_time_passing"
    t.string "platform"
    t.text "activities"
    t.text "planned_activities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_timetable_calling_points_on_station_id"
    t.index ["timetable_id"], name: "index_timetable_calling_points_on_timetable_id"
    t.index ["timing_point_id"], name: "index_timetable_calling_points_on_timing_point_id"
  end

  create_table "timetables", id: :serial, force: :cascade do |t|
    t.string "rtti_id"
    t.string "uuid"
    t.integer "operator_id"
    t.string "train_id"
    t.string "schedule_id"
    t.date "start_date"
    t.string "train_type"
    t.string "train_category"
    t.text "late_running_reason"
    t.text "cancellation_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_timetables_on_uuid"
  end

  create_table "timing_points", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "uuid"
    t.integer "station_id"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stanox"
    t.index ["code", "uuid", "station_id"], name: "index_timing_points_on_code_and_uuid_and_station_id"
    t.index ["stanox"], name: "index_timing_points_on_stanox"
  end

  create_table "tube_lines", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "number"
    t.string "background_colour"
    t.string "text_colour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["code", "number"], name: "index_tube_lines_on_code_and_number"
    t.index ["uuid"], name: "index_tube_lines_on_uuid", unique: true
  end

  create_table "user_badges", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_favourite_stations", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "station_id", null: false
    t.index ["station_id", "user_id"], name: "index_user_favourite_stations_on_station_id_and_user_id"
    t.index ["user_id", "station_id"], name: "index_user_favourite_stations_on_user_id_and_station_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "home_station_id"
    t.integer "work_station_id"
    t.string "uuid"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["home_station_id"], name: "index_users_on_home_station_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
    t.index ["work_station_id"], name: "index_users_on_work_station_id"
  end

  add_foreign_key "journey_legs", "journeys"
  add_foreign_key "journey_legs", "operators"
  add_foreign_key "journeys", "users"
  add_foreign_key "ppms", "operators"
end
