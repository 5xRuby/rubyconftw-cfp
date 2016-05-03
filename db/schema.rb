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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20160420061757) do

  create_table "papers", force: :cascade do |t|
    t.string   "Title"
    t.string   "Abstract"
    t.string   "Outline"
    t.string   "FileName"
    t.string   "Status"
=======
ActiveRecord::Schema.define(version: 20160503040959) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "subtitle"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "term"
>>>>>>> 61185c32744788f8e79e4da5f8bca25786f522df
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
