# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_16_091526) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "category"
    t.string "isbn", null: false
    t.date "date_of_publication"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "club_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "club_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_users_on_club_id"
    t.index ["user_id"], name: "index_club_users_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "label"
    t.string "description"
    t.string "club_admin"
    t.string "invitation_code", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "propositions", force: :cascade do |t|
    t.bigint "reading_session_id", null: false
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_propositions_on_book_id"
    t.index ["reading_session_id"], name: "index_propositions_on_reading_session_id"
    t.index ["user_id"], name: "index_propositions_on_user_id"
  end

  create_table "reading_sessions", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "name", null: false
    t.string "state", default: "submission", null: false
    t.datetime "next_step_date"
    t.datetime "read_due_date"
    t.datetime "submission_due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "selected_book_id"
    t.index ["club_id"], name: "index_reading_sessions_on_club_id"
    t.index ["selected_book_id"], name: "index_reading_sessions_on_selected_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "username", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "club_users", "clubs"
  add_foreign_key "club_users", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "propositions", "books"
  add_foreign_key "propositions", "reading_sessions"
  add_foreign_key "propositions", "users"
  add_foreign_key "reading_sessions", "books", column: "selected_book_id"
  add_foreign_key "reading_sessions", "clubs"
end
