require_relative '../test_helper'

class LegacyEntityTest < ActiveSupport::TestCase
  def test_create_defaults
    raw_data = {
      integer: 1,
      boolean: false
    }.freeze

    legacy_entity = LegacyEntity.create(
      raw_data: raw_data
    )

    assert_created legacy_entity

    legacy_entity = LegacyEntity.find(legacy_entity.id)

    assert_equal raw_data.stringify_keys, legacy_entity.raw_data
  end

  def test_create_requirements
    legacy_entity = LegacyEntity.create

    assert_created legacy_entity

    expected_raw_data = { }

    assert_equal expected_raw_data, legacy_entity.raw_data
  end
end
