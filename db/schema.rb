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

ActiveRecord::Schema.define(version: 20160808041700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "term"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "papers_count",     default: 0
    t.date     "event_start_date"
    t.date     "event_end_date"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "custom_fields", force: :cascade do |t|
    t.integer  "sort_order",             default: 0
    t.string   "name",        limit: 64
    t.integer  "activity_id"
    t.string   "field_type",  limit: 48
    t.boolean  "required",               default: false
    t.jsonb    "options",                default: {}
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "description"
    t.string   "collection",             default: [],                 array: true
  end

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.text     "abstract"
    t.text     "outline"
    t.string   "speaker_avatar"
    t.string   "state"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "activity_id"
    t.integer  "user_id"
    t.string   "inviting_email"
    t.jsonb    "answer_of_custom_fields",            default: {}
    t.string   "speaker_name"
    t.string   "speaker_company_or_org"
    t.string   "speaker_title"
    t.string   "speaker_country_code",    limit: 8
    t.string   "speaker_site"
    t.text     "pitch"
    t.text     "speaker_bio"
    t.string   "language",                limit: 32
    t.string   "uuid",                    limit: 8
    t.integer  "reviews_count"
    t.index ["activity_id"], name: "index_papers_on_activity_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "paper_id"
    t.boolean  "reviewed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paper_id"], name: "index_reviews_on_paper_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "user_activity_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "is_reviewer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.boolean  "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "papers", "activities"
end
