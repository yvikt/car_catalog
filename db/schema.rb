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

ActiveRecord::Schema.define(version: 20200830082423) do

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "bg_color"
    t.string   "font_color"
    t.string   "border_color"
    t.string   "tag_category"
    t.boolean  "customized"
  end

  create_table "tags_vehicles", id: false, force: :cascade do |t|
    t.integer "tag_id",     null: false
    t.integer "vehicle_id", null: false
  end

  add_index "tags_vehicles", ["tag_id", "vehicle_id"], name: "index_tags_vehicles_on_tag_id_and_vehicle_id"
  add_index "tags_vehicles", ["vehicle_id", "tag_id"], name: "index_tags_vehicles_on_vehicle_id_and_tag_id"

  create_table "vehicles", force: :cascade do |t|
    t.string   "model"
    t.integer  "year"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "img_url"
    t.text     "description"
  end

end
