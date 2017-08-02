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

ActiveRecord::Schema.define(version: 20170210162957) do

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
    t.index ["company_id"], name: "index_admins_on_company_id", using: :btree
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "agreements", force: :cascade do |t|
    t.string   "type"
    t.text     "agreement_text"
    t.string   "language"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

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
    t.string   "layout"
    t.float    "lat"
    t.float    "lng"
    t.string   "router_auth"
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "company_id"
    t.macaddr  "mac"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.integer  "user_id"
    t.index ["company_id"], name: "index_devices_on_company_id", using: :btree
    t.index ["user_id"], name: "index_devices_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "provider"
    t.integer  "company_id"
    t.index ["company_id"], name: "index_events_on_company_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

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
    t.string   "api_key"
    t.string   "api_secret"
    t.index ["company_id"], name: "index_fbs_on_company_id", using: :btree
  end

  create_table "guests", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "action"
    t.string   "link_redirect"
    t.string   "wall_head"
    t.text     "wall_text"
    t.string   "wall_image"
    t.boolean  "adv",             default: false
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["company_id"], name: "index_guests_on_company_id", using: :btree
  end

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
    t.string   "api_key"
    t.string   "api_secret"
    t.index ["company_id"], name: "index_ins_on_company_id", using: :btree
  end

  create_table "networks", force: :cascade do |t|
    t.integer  "company_id"
    t.cidr     "local_network"
    t.inet     "local_range_begin"
    t.inet     "local_range_end"
    t.inet     "local_gateway"
    t.cidr     "hotspot_network"
    t.inet     "hotspot_range_begin"
    t.inet     "hotspot_range_end"
    t.inet     "hotspot_gateway"
    t.inet     "hotspot_address"
    t.inet     "net"
    t.integer  "lease_time"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["company_id"], name: "index_networks_on_company_id", using: :btree
    t.string   "wifi_password"
  end

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
    t.string   "api_key"
    t.string   "api_secret"
    t.string   "api_public"
    t.index ["company_id"], name: "index_oks_on_company_id", using: :btree
  end

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
    t.string   "ssid"
    t.macaddr  "radio_mac"
    t.index ["company_id"], name: "index_routers_on_company_id", using: :btree
    t.index ["ip_address", "company_id"], name: "index_routers_on_ip_address_and_company_id", unique: true, using: :btree
  end

  create_table "sms", force: :cascade do |t|
    t.integer "company_id"
    t.string  "action"
    t.string  "link_redirect"
    t.string  "wall_head"
    t.text    "wall_text"
    t.string  "wall_image"
    t.boolean "adv",           default: false
    t.index ["company_id"], name: "index_sms_on_company_id", using: :btree
  end

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
    t.index ["company_id"], name: "index_statistics_on_company_id", using: :btree
    t.index ["user_id"], name: "index_statistics_on_user_id", using: :btree
  end

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
    t.string   "api_key"
    t.string   "api_secret"
    t.index ["company_id"], name: "index_tws_on_company_id", using: :btree
  end

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
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
  end

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
    t.string   "api_key"
    t.string   "api_secret"
    t.index ["company_id"], name: "index_vks_on_company_id", using: :btree
  end

  add_foreign_key "admins", "companies"
  add_foreign_key "events", "companies"
  add_foreign_key "events", "users"
  add_foreign_key "fbs", "companies"
  add_foreign_key "ins", "companies"
  add_foreign_key "networks", "companies"
  add_foreign_key "oks", "companies"
  add_foreign_key "statistics", "companies"
  add_foreign_key "statistics", "users"
  add_foreign_key "tws", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "vks", "companies"
end
