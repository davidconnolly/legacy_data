class CreateLegacyEntities < ActiveRecord::Migration
  def change
    create_table :legacy_entities do |t|
      t.belongs_to :legacy_source      
      t.integer :raw_identity
      t.json :raw_data
      t.json :extracted_data
      t.json :error_data
      t.boolean :locked
      t.boolean :import
      t.timestamps
    end
  end
end
