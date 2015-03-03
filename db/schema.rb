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

ActiveRecord::Schema.define(version: 20150215030454) do

  create_table "ab_list", force: true do |t|
    t.string "part", limit: 5
    t.string "name", limit: 45
  end

  add_index "ab_list", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "answers", id: false, force: true do |t|
    t.string  "user",   limit: 100, null: false
    t.integer "q_no",               null: false
    t.integer "answer",             null: false
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

  create_table "nontan_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nontans", force: true do |t|
    t.integer  "practice_pln_id",                                 null: false
    t.integer  "part_id",                                         null: false
    t.string   "user_name",                                       null: false
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

  create_table "result", id: false, force: true do |t|
    t.string  "''''||a.user||''','", limit: 103
    t.integer "count(a.user)",       limit: 8,   default: 0, null: false
  end

  create_table "sharedfiles", force: true do |t|
    t.string   "filepath"
    t.text     "description"
    t.integer  "category"
    t.string   "uploader"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
