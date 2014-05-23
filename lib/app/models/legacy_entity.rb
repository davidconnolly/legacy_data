class LegacyEntity < ActiveRecord::Base
  # == Constants =============================================================

  # == Properties ============================================================

  # == Extensions ============================================================

  # == Relationships =========================================================

  belongs_to :legacy_source
  has_many :legacy_extracted_records

  # == Validations ===========================================================

  # == Callbacks =============================================================

  before_validation :assign_default_values

  # == Scopes ================================================================

  # == Class Methods =========================================================

  def self.raw_data_remapped(mapping)
    all.collect do |entity|
      entity.raw_data_remapped(mapping)
    end
  end
  
  def self.generate_CSV_error_report
    CSV.generate do |csv|
        csv << ["Source", "Source Identity", "Errors"]

      LegacyEntity.where('(select count(*) from json_each(error_data)) != ?', 0).each do |legacy_entity|
        csv << [ LegacySource.find(legacy_entity.legacy_source_id).name, legacy_entity.raw_identity, legacy_entity.error_data]
      end

      csv
    end
  end

  # == Instance Methods ======================================================

  def raw_data_remapped(mapping)
    Hash[
      mapping.collect do |key, value|
        [ value, self.raw_data[key] ]
      end
    ]
  end

protected
  def assign_default_values
    return if (self.raw_data?)

    self.raw_data = { }
  end
end
