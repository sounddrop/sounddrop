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

ActiveRecord::Schema.define(version: 20150918094354) do

  create_table "drops", force: :cascade do |t|
    t.string   "title"
    t.integer  "sc_track"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "longitude"
    t.decimal  "latitude"
  end

  add_index "places", ["name"], name: "index_places_on_name", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "drop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
