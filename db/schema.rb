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

ActiveRecord::Schema.define(version: 20140209224321) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "dcm_account_code"
    t.string   "features"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "e911s", force: true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subscriber_list_file_name"
    t.string   "subscriber_list_content_type"
    t.integer  "subscriber_list_file_size"
    t.datetime "subscriber_list_updated_at"
    t.integer  "subscriber_list_row_count"
  end

  create_table "e911s_notifications", force: true do |t|
    t.integer "e911_id"
    t.integer "notification_id"
  end

  add_index "e911s_notifications", ["e911_id"], name: "index_e911s_notifications_on_e911_id", using: :btree
  add_index "e911s_notifications", ["notification_id"], name: "index_e911s_notifications_on_notification_id", using: :btree

  create_table "geos", force: true do |t|
    t.string   "type"
    t.string   "shape"
    t.string   "search_value"
    t.string   "map_bounds"
    t.text     "coordinates"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "geojson"
    t.integer  "notification_id"
    t.integer  "account_id"
    t.string   "sse_channel"
    t.string   "name"
  end

  add_index "geos", ["account_id"], name: "index_geos_on_account_id", using: :btree
  add_index "geos", ["notification_id"], name: "index_geos_on_notification_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "dcm_topic_id"
    t.string   "dcm_account_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.integer  "account_id"
    t.string   "sse_channel"
    t.integer  "geo_id"
  end

  add_index "notifications", ["account_id"], name: "index_notifications_on_account_id", using: :btree
  add_index "notifications", ["dcm_account_code"], name: "index_notifications_on_dcm_account_code", unique: true, using: :btree
  add_index "notifications", ["geo_id"], name: "index_notifications_on_geo_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.integer  "account_id"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
