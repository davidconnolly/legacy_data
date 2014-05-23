ActiveRecord::Schema.define(version: 20140520035838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legacy_entities", force: true do |t|
    t.integer  "legacy_source_id"
    t.integer  "raw_identity"
    t.json     "raw_data"
    t.json     "extracted_data"
    t.json     "error_data"
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
