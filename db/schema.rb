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

ActiveRecord::Schema.define(version: 20160512172706) do

  create_table "ab_list", force: true do |t|
    t.string "part", limit: 5
    t.string "name", limit: 45
  end

  add_index "ab_list", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "account_transactions", force: true do |t|
    t.integer  "amount"
    t.string   "fit_id"
    t.string   "name"
    t.datetime "posted_at"
    t.string   "transaction_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounting_items", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "is_debit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_responsibles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "admin_class", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "url",        limit: 511
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
    t.text     "president_memo"
    t.date     "president_accepted_at"
    t.text     "somu_memo"
    t.date     "somu_accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_attendances", force: true do |t|
    t.integer  "user_id"
    t.boolean  "by_car"
    t.text     "memo"
    t.integer  "section_1"
    t.integer  "section_2"
    t.integer  "section_3"
    t.integer  "section_4"
    t.integer  "section_5"
    t.integer  "section_6"
    t.integer  "section_7"
    t.integer  "section_8"
    t.integer  "section_9"
    t.integer  "section_10"
    t.integer  "section_11"
    t.integer  "section_12"
    t.integer  "section_13"
    t.integer  "section_14"
    t.integer  "section_15"
    t.integer  "section_16"
    t.integer  "section_17"
    t.integer  "section_18"
    t.integer  "section_19"
    t.integer  "section_20"
    t.integer  "section_21"
    t.integer  "section_22"
    t.integer  "section_23"
    t.integer  "section_24"
    t.integer  "section_25"
    t.integer  "section_26"
    t.integer  "section_27"
    t.integer  "section_28"
    t.integer  "section_29"
    t.integer  "section_30"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_sections", force: true do |t|
    t.date     "pln_date"
    t.string   "title"
    t.text     "memo"
    t.integer  "amount"
    t.time     "start_at"
    t.time     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camps", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "first_poll_start_at"
    t.date     "fiest_poll_end_at"
    t.date     "final_poll_start_at"
    t.date     "final_poll_end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "supporter"
    t.string   "ticket_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constant_texts", force: true do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constant_values", force: true do |t|
    t.string   "key"
    t.string   "value"
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

  create_table "fee_cutoffs", force: true do |t|
    t.date     "cutoff_date"
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
    t.date     "fee_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_absent",  default: false
    t.boolean  "is_student", default: false
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
    t.integer  "member"
  end

  create_table "payees", force: true do |t|
    t.string   "index"
    t.string   "name"
    t.integer  "user_id"
    t.string   "net_banking_label"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "helper"
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

  create_table "slip_dtls", force: true do |t|
    t.integer  "slip_id"
    t.date     "trans_date"
    t.integer  "accounting_item_id"
    t.string   "memo"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slip_mappings", force: true do |t|
    t.integer  "slip_id"
    t.integer  "account_transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slips", force: true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.boolean  "transferred"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payee_class"
    t.integer  "payee_id"
    t.string   "bank_name"
    t.string   "bank_branch"
    t.string   "bank_account"
    t.string   "account_holder"
    t.string   "payer_name"
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
    t.string   "access_token",  limit: 2048
    t.string   "access_secret", limit: 2048
  end

  add_index "social_profiles", ["user_id"], name: "index_social_profiles_on_user_id", using: :btree

  create_table "ticket_reservation_collections", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_reservations", force: true do |t|
    t.integer  "user_id"
    t.string   "esp_name"
    t.string   "name"
    t.string   "fname"
    t.string   "name_pron"
    t.string   "fname_pron"
    t.integer  "num_of_ticket"
    t.boolean  "received",                         default: false, null: false
    t.integer  "concert_id"
    t.integer  "ticket_reservation_collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string    "title"
    t.string    "link"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "family_name",            limit: 50
    t.string   "name",                   limit: 50
    t.string   "family_name_pron",       limit: 50
    t.string   "name_pron",              limit: 50
    t.string   "nickname",               limit: 50
    t.integer  "profession"
    t.integer  "part_id"
    t.boolean  "admin_member",                      default: false
    t.string   "email",                             default: "",                                                       null: false
    t.string   "email2"
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
    t.string   "bank"
    t.string   "bank_branch"
    t.string   "bank_account"
    t.string   "bank_name"
    t.boolean  "retired",                           default: false
    t.string   "net_banking_label"
    t.string   "disclosed_phone"
    t.string   "mobile_mail"
    t.string   "pc_mail"
    t.string   "job"
    t.string   "grad_school"
    t.string   "major"
    t.string   "favorite"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "mixi"
    t.string   "github"
    t.string   "googleplus"
    t.string   "tumblr"
    t.string   "linkedin"
    t.string   "flickr"
    t.string   "ameba"
    t.string   "hatena"
    t.string   "line"
    t.string   "yelp"
    t.string   "yahoo"
    t.string   "bing"
    t.string   "instagram"
    t.string   "behance"
    t.string   "origin"
    t.string   "blood"
    t.date     "birthday"
  end

  create_table "v_fee_calcs", id: false, force: true do |t|
    t.integer "user_id",                                         default: 0, null: false
    t.string  "family_name", limit: 50
    t.string  "name",        limit: 50
    t.decimal "amount",                 precision: 32, scale: 0, default: 0, null: false
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

  create_table "vouchers", force: true do |t|
    t.integer  "slip_id"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
