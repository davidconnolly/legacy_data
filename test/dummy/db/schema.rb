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

ActiveRecord::Schema.define(version: 20140520035838) do

  create_table "legacy_entities", force: true do |t|
    t.integer  "legacy_source_id"
    t.integer  "raw_identity"
    t.text     "raw_data"
    t.text     "extracted_data"
    t.boolean  "locked"
    t.boolean  "import"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legacy_extracted_records", force: true do |t|
    t.integer  "legacy_entity_id"
    t.string   "record_type"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legacy_sources", force: true do |t|
    t.string   "name"
    t.string   "file"
    t.string   "path"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
