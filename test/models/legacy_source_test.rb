require_relative '../test_helper'

class LegacySourceTest < ActiveSupport::TestCase
  def test_create_defaults
    legacy_source = LegacySource.create(
      name: "Test Source"
    )

    assert_created legacy_source

    assert_equal "Test Source", legacy_source.name
    assert_equal nil, legacy_source.file
    assert_equal nil, legacy_source.path

    assert_equal 0, legacy_source.legacy_entities.count
  end

  def test_create_requirements
    legacy_source = LegacySource.create

    assert_created legacy_source
  end

  def test_create_dummy
    legacy_source = LegacySource.create

    assert_created legacy_source
  end
end
