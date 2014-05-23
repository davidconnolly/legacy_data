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

  def test_raw_data_remapped
    legacy_entity = LegacyEntity.create(
      raw_data: {
        'swedish_band' => 'ABBA',
        'canadian_band' => 'Arcade Fire',
        'american_band' => 'Aerosmith'
      }
    )

    assert_created legacy_entity

    remapping = {
      'canadian_band' => '2000s',
      'american_band' => '1990s',
      'swedish_band' => '1970s'
    }

    expected_raw_data = {
      '1990s' => 'Aerosmith',
      '2000s' => 'Arcade Fire',
      '1970s' => 'ABBA'
    }

    assert_equal expected_raw_data, legacy_entity.raw_data_remapped(remapping)

    assert_equal expected_raw_data, LegacyEntity.raw_data_remapped(remapping)[0]
  end

  def test_create_dummy
    legacy_entity = LegacyEntity.create

    assert_created legacy_entity
  end
end
