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

ActiveRecord::Schema.define(version: 20150405032204) do

  create_table "agents", force: :cascade do |t|
    t.string   "name"
    t.integer  "worth"
    t.string   "agentType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "agents", ["name"], name: "index_agents_on_name", unique: true

  create_table "events", force: :cascade do |t|
    t.integer  "amount"
    t.datetime "dateTime"
    t.string   "fromAgent"
    t.string   "toAgent"
    t.string   "eventType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
