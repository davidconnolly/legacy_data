class CreateLegacySources < ActiveRecord::Migration
  def change
    create_table :legacy_sources do |t|
      t.string :name
      t.string :file
      t.string :path
      t.string :format
      t.timestamps
    end
  end
end
