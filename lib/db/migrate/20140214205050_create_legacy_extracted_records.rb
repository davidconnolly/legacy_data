class CreateLegacyExtractedRecords < ActiveRecord::Migration
  def change
    create_table :legacy_extracted_records do |t|
      t.belongs_to :legacy_entity
      t.string :record_type
      t.integer :record_id
      t.timestamps
    end
  end
end
