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

ActiveRecord::Schema.define(version: 20160524032057) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "term"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "papers_count", default: 0
  end

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.text     "abstract"
    t.text     "outline"
    t.string   "file_name"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "activity_id"
    t.integer  "user_id"
  end

  add_index "papers", ["activity_id"], name: "index_papers_on_activity_id"

  create_table "user_activity_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "isReviewer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_paper_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "paper_id"
    t.boolean  "is_author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password", default: "", null: false
    t.string   "email",              default: "", null: false
    t.string   "name"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "title"
    t.string   "company"
    t.string   "country"
    t.string   "photo"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
