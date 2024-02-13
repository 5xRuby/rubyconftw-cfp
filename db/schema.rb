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

ActiveRecord::Schema.define(version: 2024_02_13_043547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "logo"
    t.date "start_date"
    t.date "end_date"
    t.text "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "papers_count", default: 0
    t.datetime "open_at"
    t.datetime "close_at"
    t.string "permalink"
    t.boolean "accept_attachement"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "text"
    t.integer "user_id"
    t.integer "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_fields", id: :serial, force: :cascade do |t|
    t.integer "sort_order", default: 0
    t.string "name", limit: 64
    t.integer "activity_id"
    t.string "field_type", limit: 48
    t.boolean "required", default: false
    t.jsonb "options", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "collection", default: [], array: true
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "state"
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.text "cron_key"
    t.uuid "retried_good_job_id"
    t.datetime "cron_at"
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["active_job_id"], name: "index_good_jobs_on_active_job_id"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at", unique: true
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at", where: "((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL))"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "notifiers", id: :serial, force: :cascade do |t|
    t.integer "activity_id"
    t.string "name"
    t.boolean "enabled", default: true
    t.boolean "on_new_comment", default: false
    t.boolean "on_new_paper", default: false
    t.boolean "on_paper_status_changed", default: false
    t.string "service_name", default: ""
    t.jsonb "service_info", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "papers", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.text "outline"
    t.string "speaker_avatar"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id"
    t.integer "user_id"
    t.string "inviting_email"
    t.jsonb "answer_of_custom_fields", default: {}
    t.string "speaker_name"
    t.string "speaker_company_or_org"
    t.string "speaker_title"
    t.string "speaker_country_code", limit: 8
    t.string "speaker_site"
    t.text "pitch"
    t.text "speaker_bio"
    t.string "language", limit: 32
    t.string "uuid", limit: 8
    t.integer "reviews_count", default: 0
    t.string "attachement"
    t.index ["activity_id"], name: "index_papers_on_activity_id"
    t.index ["uuid"], name: "index_papers_on_uuid"
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "paper_id"
    t.string "reviewed", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["paper_id"], name: "index_reviews_on_paper_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_activity_relationships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.boolean "is_reviewer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "email", default: "", null: false
    t.string "name"
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.string "title"
    t.string "company"
    t.string "country"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "is_admin"
    t.boolean "is_contributor", default: false
    t.string "twitter"
    t.string "github_username"
    t.boolean "is_superadmin", default: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["is_contributor"], name: "index_users_on_is_contributor"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "papers", "activities"

  create_view "custom_field_answers",  sql_definition: <<-SQL
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
