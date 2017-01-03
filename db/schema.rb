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

ActiveRecord::Schema.define(version: 20161226193925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "protected"
    t.string   "cover_image"
    t.boolean  "cover_is_landscape"
    t.datetime "created"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "photo_settings", force: :cascade do |t|
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "setting_id"
  end

  add_index "photo_settings", ["photo_id"], name: "index_photo_settings_on_photo_id", using: :btree
  add_index "photo_settings", ["setting_id"], name: "index_photo_settings_on_setting_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.boolean  "is_featured"
    t.boolean  "is_landscape"
    t.string   "tags"
    t.string   "name"
    t.string   "description"
    t.boolean  "protected"
    t.string   "url"
    t.datetime "created"
    t.integer  "gallery_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "copyright"
    t.string   "exposure_time"
    t.float    "fstop"
    t.string   "focal_length"
    t.integer  "iso"
    t.string   "make"
    t.string   "model"
    t.datetime "date"
    t.float    "gps_lat"
    t.float    "gps_long"
    t.string   "lens"
    t.integer  "order"
  end

  add_index "photos", ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "size"
    t.float    "price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "medium"
    t.float    "dealer_cost"
    t.string   "dealer"
    t.boolean  "has_free_shipping"
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "photo_id"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["photo_id"], name: "index_tags_on_photo_id", using: :btree

  add_foreign_key "photo_settings", "photos"
  add_foreign_key "photo_settings", "settings"
  add_foreign_key "photos", "galleries"
  add_foreign_key "tags", "photos"
end
