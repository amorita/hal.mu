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

ActiveRecord::Schema.define(version: 20150517075136) do

  create_table "ab_list", force: true do |t|
    t.string "part", limit: 5
    t.string "name", limit: 45
  end

  add_index "ab_list", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "albums", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "url"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", id: false, force: true do |t|
    t.string  "user",   limit: 100, null: false
    t.integer "q_no",               null: false
    t.integer "answer",             null: false
  end

  create_table "applications", force: true do |t|
    t.integer  "user_id"
    t.text     "user_memo"
    t.date     "starts_at"
    t.date     "ends_at"
    t.string   "application_type",      limit: 50
    t.integer  "part_user_id"
    t.text     "part_memo"
    t.date     "part_accepted_at"
    t.text     "somu_memo"
    t.date     "somu_accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "president_accepted_at"
    t.text     "president_memo"
  end

  create_table "concert_programs", force: true do |t|
    t.integer  "concert_id"
    t.integer  "order"
    t.string   "composer"
    t.string   "name"
    t.string   "sub_title"
    t.text     "note",       limit: 16777215
    t.string   "writer"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "concerts", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "place"
    t.string   "hall"
    t.string   "conductor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enq_ages", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enq_answers", force: true do |t|
    t.integer  "enq_gender_id"
    t.integer  "enq_age_id"
    t.integer  "enq_time_req_id"
    t.integer  "enq_district_id"
    t.integer  "enq_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "memo",            limit: 2000
    t.integer  "concert_no"
  end

  create_table "enq_districts", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enq_genders", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enq_sources", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enq_time_reqs", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_attendances", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "when"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "invite_until"
    t.integer  "alert_days_before"
    t.date     "ends_at"
  end

  create_table "fee_amounts", force: true do |t|
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "workers"
    t.integer  "students"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "google_cal", id: false, force: true do |t|
    t.date   "Start Date"
    t.string "Start Time",      limit: 14
    t.date   "End Date"
    t.string "End Time",        limit: 14
    t.text   "Descripton"
    t.string "Location",        limit: 203, default: "", null: false
    t.string "Subject",         limit: 150
    t.string "Reminder On/Off", limit: 3,   default: "", null: false
  end

  create_table "monthly_fees", force: true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nontan_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nontans", force: true do |t|
    t.integer  "practice_pln_id",                                 null: false
    t.integer  "part_id",                                         null: false
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "subs_user_id"
    t.string   "subs_name"
    t.string   "reason",                                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nontan_class_id", default: 2,                     null: false
    t.datetime "time",            default: '1900-01-01 00:00:00', null: false
  end

  create_table "parts", force: true do |t|
    t.string   "name"
    t.string   "abbr"
    t.boolean  "need_subs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "poster_candidates", force: true do |t|
    t.integer  "selection"
    t.string   "mail"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practice_mode", force: true do |t|
    t.string "name", limit: 45, null: false
  end

  create_table "practice_place", force: true do |t|
    t.string  "place_name",  limit: 100,              null: false
    t.string  "description", limit: 1000,             null: false
    t.string  "address",     limit: 1000,             null: false
    t.string  "url",         limit: 200,              null: false
    t.string  "map_url",     limit: 500,              null: false
    t.integer "show_flg",                 default: 1, null: false
  end

  create_table "practice_pln", force: true do |t|
    t.date    "pln_date"
    t.string  "room",        limit: 100
    t.integer "begining",                 default: 1800
    t.integer "ending",                   default: 2100
    t.string  "description", limit: 1000
    t.integer "mode",                     default: 0
    t.integer "place",                    default: 0
    t.string  "uuid",        limit: 100
  end

  add_index "practice_pln", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "practice_pln_sums", id: false, force: true do |t|
    t.integer "id",                   default: 0, null: false
    t.date    "pln_date"
    t.string  "text",     limit: 152
  end

  create_table "questions", primary_key: "no", force: true do |t|
    t.string  "question",  limit: 1000,             null: false
    t.integer "available",              default: 0, null: false
    t.integer "answer"
  end

  create_table "responsibles", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "result", id: false, force: true do |t|
    t.string  "''''||a.user||''','", limit: 103
    t.integer "count(a.user)",       limit: 8,   default: 0, null: false
  end

  create_table "sharedfiles", force: true do |t|
    t.string   "filepath"
    t.text     "description",      limit: 16777215
    t.integer  "file_category_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "url"
    t.string   "image_url"
    t.string   "description"
    t.text     "other"
    t.text     "credentials"
    t.text     "raw_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "access_secret"
  end

  add_index "social_profiles", ["user_id"], name: "index_social_profiles_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "family_name",            limit: 50
    t.string   "name",                   limit: 50
    t.string   "family_name_pron",       limit: 50
    t.string   "name_pron",              limit: 50
    t.string   "nickname",               limit: 50
    t.integer  "profession"
    t.integer  "part_id"
    t.string   "email",                             default: "",                                                       null: false
    t.string   "phone",                  limit: 50
    t.string   "zip_code",               limit: 50
    t.string   "address",                limit: 50
    t.string   "building"
    t.string   "initial_access_token",              default: "SELECT LPAD(FLOOR(RAND() * 1000000), 6, '0') FROM DUAL"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,                                                        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                             default: false
    t.boolean  "worker",                            default: true
    t.string   "school"
  end

  create_table "views", force: true do |t|
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
  end

  add_index "views", ["email"], name: "index_views_on_email", unique: true, using: :btree
  add_index "views", ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true, using: :btree

end
