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

ActiveRecord::Schema.define(version: 20160614170438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "company_id"
    t.boolean  "admin"
    t.boolean  "active",                 default: true
  end

  add_index "admins", ["company_id"], name: "index_admins_on_company_id", using: :btree
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "token"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "owner_name"
    t.string   "cover"
    t.string   "card"
    t.boolean  "tos",                    default: false
    t.text     "tos_text"
    t.boolean  "active",                 default: true
    t.string   "sms_auth",               default: "disabled"
    t.string   "sms_auth_link_redirect"
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "company_id"
    t.macaddr  "mac"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.integer  "user_id"
  end

  add_index "devices", ["company_id"], name: "index_devices_on_company_id", using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "provider"
    t.integer  "company_id"
  end

  add_index "events", ["company_id"], name: "index_events_on_company_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "fbs", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "group_id"
    t.string   "group_name"
    t.string   "action"
    t.string   "link_redirect"
    t.text     "post_text"
    t.string   "post_link"
    t.string   "post_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "fbs", ["company_id"], name: "index_fbs_on_company_id", using: :btree

  create_table "ins", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "group_id"
    t.string   "group_name"
    t.string   "action"
    t.string   "link_redirect"
    t.string   "post_text"
    t.string   "post_link"
    t.string   "post_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ins", ["company_id"], name: "index_ins_on_company_id", using: :btree

  create_table "oks", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "group_id"
    t.string   "group_name"
    t.string   "action"
    t.string   "link_redirect"
    t.string   "post_text"
    t.string   "post_link"
    t.string   "post_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "oks", ["company_id"], name: "index_oks_on_company_id", using: :btree

  create_table "routers", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "ip_address",                     null: false
    t.string   "name"
    t.string   "login",                          null: false
    t.string   "password",                       null: false
    t.boolean  "available",      default: false
    t.datetime "last_pinged_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routers", ["company_id"], name: "index_routers_on_company_id", using: :btree
  add_index "routers", ["ip_address", "company_id"], name: "index_routers_on_ip_address_and_company_id", unique: true, using: :btree

  create_table "sms", force: :cascade do |t|
    t.integer "company_id"
    t.string  "action"
    t.string  "link_redirect"
    t.string  "wall_head"
    t.text    "wall_text"
    t.string  "wall_image"
    t.boolean "adv",           default: false
  end

  add_index "sms", ["company_id"], name: "index_sms_on_company_id", using: :btree

  create_table "statistics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "provider"
    t.string   "platform"
    t.string   "platform_version"
    t.string   "browser"
    t.string   "browser_version"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.macaddr  "mac"
  end

  add_index "statistics", ["company_id"], name: "index_statistics_on_company_id", using: :btree
  add_index "statistics", ["user_id"], name: "index_statistics_on_user_id", using: :btree

  create_table "tws", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "group_id"
    t.string   "group_name"
    t.string   "action"
    t.string   "link_redirect"
    t.text     "post_text"
    t.string   "post_link"
    t.string   "post_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tws", ["company_id"], name: "index_tws_on_company_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "birthday"
    t.string   "url"
    t.integer  "company_id"
    t.string   "email"
    t.string   "gender"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree

  create_table "vks", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "group_id"
    t.string   "group_name"
    t.string   "action"
    t.string   "link_redirect"
    t.text     "post_text"
    t.string   "post_link"
    t.string   "post_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "vks", ["company_id"], name: "index_vks_on_company_id", using: :btree

  add_foreign_key "admins", "companies"
  add_foreign_key "events", "companies"
  add_foreign_key "events", "users"
  add_foreign_key "fbs", "companies"
  add_foreign_key "ins", "companies"
  add_foreign_key "oks", "companies"
  add_foreign_key "statistics", "companies"
  add_foreign_key "statistics", "users"
  add_foreign_key "tws", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "vks", "companies"
end
