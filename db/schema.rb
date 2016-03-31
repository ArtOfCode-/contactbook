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

ActiveRecord::Schema.define(version: 20160330171520) do

  create_table "contacts", force: :cascade do |t|
    t.string   "title"
    t.string   "first",                     null: false
    t.string   "last",                      null: false
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "created_by",   default: -1, null: false
    t.boolean  "is_encrypted"
  end

  create_table "site_notices", force: :cascade do |t|
    t.string   "text"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "is_admin",           default: false, null: false
    t.boolean  "is_confirmed"
    t.string   "confirmation_token"
  end

end
