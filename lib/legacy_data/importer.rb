class Legacy::Importer
  # == Instance Methods =====================================================

  def initialize(source)
    @source = source
  end

  def all
    [
      self.people
    ].flatten
  end

  def people
    people = @source.extracted_data["people"]

    return [ ] unless (people)

    objects_created = []

    people.collect do |person_attributes| 
      objects_created.push(Person.create!(person_attributes))
    end

    objects_created
  end

  def import!
    ActiveRecord::Base.transaction do
      self.all.each do |record|
        begin
          LegacyExtractedRecord.create!(
            legacy_entity: @source,
            record: record
          )

        rescue => e
          @source.error_data = @source.error_data.merge(
            IMPORT_FAILED: "Unable to import LegacyEntity #{@source.id}: #{record}"
          )
          @source.save!
          
          alert("ERROR: Unable to import LegacyEntity #{@source.id}: #{record} [#{e.class}] #{e}")
        
        ensure
          @source.save!
        end
      end
    end
  end

protected
  def alert(message)
    STDERR.puts(message)
    Rails.logger.debug(message)
  end
end
