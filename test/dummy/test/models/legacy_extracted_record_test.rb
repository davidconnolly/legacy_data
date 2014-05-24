require_relative '../test_helper'

class LegacyExtractedRecordTest < ActiveSupport::TestCase
  def test_create_defaults
    legacy_entity = LegacyEntity.create
    associated_object = LegacyEntity.create

    legacy_extracted_record = LegacyExtractedRecord.create(
      legacy_entity: legacy_entity,
      record: associated_object
    )

    assert_created legacy_extracted_record
  end

  def test_create_requirements
    legacy_extracted_record = LegacyExtractedRecord.create

    assert_created legacy_extracted_record
  end
end
