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

ActiveRecord::Schema.define(version: 2019_06_07_095430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pages", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "next"
    t.integer "prev"
    t.string "variant", default: "", null: false
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.string "content"
    t.string "challenges"
    t.string "link"
    t.string "question"
    t.string "answers"
    t.integer "correct"
    t.integer "priority", default: -1
  end

  create_table "stations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.float "lat", default: 0.0, null: false
    t.float "lon", default: 0.0, null: false
    t.integer "next"
    t.string "line", default: "[]", null: false
    t.integer "walk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "priority"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "entry", default: 0, null: false
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "username", default: "", null: false
    t.boolean "blocked", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "walks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "location", default: "", null: false
    t.string "preview_image", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "entry", default: 0, null: false
    t.json "courseline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "public", default: false, null: false
  end

end
