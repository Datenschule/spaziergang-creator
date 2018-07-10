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

ActiveRecord::Schema.define(version: 2018_07_10_122541) do

  create_table "pages", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "next"
    t.integer "prev"
    t.string "type", default: "", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.float "lat", default: 0.0, null: false
    t.float "lon", default: 0.0, null: false
    t.integer "next"
    t.string "line", default: "[]", null: false
    t.integer "walk_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "entry", default: 0, null: false
    t.integer "station_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "walks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "location", default: "", null: false
    t.string "preview_image", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "entry", default: 0, null: false
    t.string "courseline", default: "[]", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
