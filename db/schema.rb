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

  create_table "accounts", force: true do |t|
    t.integer  "category_id"
    t.integer  "location_id"
    t.string   "slug"
    t.boolean  "incoming"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["category_id"], name: "index_accounts_on_category_id", using: :btree
  add_index "accounts", ["location_id"], name: "index_accounts_on_location_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "containers", force: true do |t|
    t.string   "name"
    t.decimal  "capacity",     precision: 6, scale: 2
    t.decimal  "empty_weight", precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfer_line_items", force: true do |t|
    t.boolean  "credit"
    t.integer  "account_id"
    t.integer  "container_id"
    t.decimal  "gross_weight", precision: 6, scale: 2
    t.decimal  "net_weight",   precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transfer_line_items", ["account_id"], name: "index_transfer_line_items_on_account_id", using: :btree
  add_index "transfer_line_items", ["container_id"], name: "index_transfer_line_items_on_container_id", using: :btree

  create_table "transfers", force: true do |t|
    t.datetime "transferred_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
