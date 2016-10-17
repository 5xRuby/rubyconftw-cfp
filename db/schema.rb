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

ActiveRecord::Schema.define(version: 20161013073416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "term"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "papers_count", default: 0
    t.datetime "open_at"
    t.datetime "close_at"
    t.string   "permalink"
  end

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer  "reviews_count",                      default: 0
    t.index ["activity_id"], name: "index_papers_on_activity_id", using: :btree
    t.index ["uuid"], name: "index_papers_on_uuid", using: :btree
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

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_activity_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "is_reviewer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password", default: "",    null: false
    t.string   "email",              default: "",    null: false
    t.string   "name"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "title"
    t.string   "company"
    t.string   "country"
    t.string   "photo"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "is_admin"
    t.boolean  "is_contributor",     default: false
    t.string   "twitter"
    t.string   "github_username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["is_contributor"], name: "index_users_on_is_contributor", using: :btree
  end

  add_foreign_key "papers", "activities"

  create_view :custom_field_answers,  sql_definition: <<-SQL
      SELECT p.id,
      c.id AS custom_field_id,
      c.name,
      c.required,
      c.activity_id,
      p.user_id,
      jsonb_extract_path(p.ans, VARIADIC ARRAY[p.key]) AS answer
     FROM (custom_fields c
       JOIN ( SELECT papers.id,
              papers.user_id,
              jsonb_object_keys(papers.answer_of_custom_fields) AS key,
              papers.answer_of_custom_fields AS ans
             FROM papers) p ON ((c.id = (p.key)::integer)));
  SQL

end
