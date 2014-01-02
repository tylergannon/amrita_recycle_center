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

ActiveRecord::Schema.define(version: 20131226052142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "containers", force: true do |t|
    t.string   "name"
    t.decimal  "capacity",     precision: 7, scale: 2
    t.decimal  "empty_weight", precision: 7, scale: 2
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfer_line_items", force: true do |t|
    t.boolean  "credit"
    t.integer  "location_id"
    t.integer  "category_id"
    t.integer  "container_id"
    t.integer  "transfer_id"
    t.decimal  "gross_weight", precision: 7, scale: 2
    t.decimal  "net_weight",   precision: 7, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transfer_line_items", ["category_id"], name: "index_transfer_line_items_on_category_id", using: :btree
  add_index "transfer_line_items", ["container_id"], name: "index_transfer_line_items_on_container_id", using: :btree
  add_index "transfer_line_items", ["location_id"], name: "index_transfer_line_items_on_location_id", using: :btree
  add_index "transfer_line_items", ["transfer_id"], name: "index_transfer_line_items_on_transfer_id", using: :btree

  create_table "transfers", force: true do |t|
    t.datetime "transferred_at"
    t.integer  "source_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
