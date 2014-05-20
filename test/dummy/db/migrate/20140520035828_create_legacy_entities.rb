class CreateLegacyEntities < ActiveRecord::Migration
  def change
    create_table :legacy_entities do |t|
      t.belongs_to :legacy_source      
      t.integer :raw_identity
      t.text :raw_data
      t.text :extracted_data
      t.boolean :locked
      t.boolean :import
      t.timestamps
    end
  end
end
