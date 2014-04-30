class Importer::GenericCsv
  # == Instance Methods =====================================================

  def initialize(path, options = nil)
    @name = options && options[:name]
    @format = options && options[:format] || @name
    @path = File.expand_path(path)
    @csv_data = CSV.new(File.open(@path))
    @header = @csv_data.first
  end

  def records
    @csv_data
  end

  def create_legacy_source!
    @legacy_source = LegacySource.new(
      name: @name,
      file: File.basename(@path),
      path: @path
    )

    records.each_with_index do |record, i|
      @legacy_source.legacy_entities.build(
        raw_identity: i + 1,
        raw_data: Hash[[ @header, record ].transpose]
      )
    end

    @legacy_source.save!

    @legacy_source
  end
end
