#!/usr/bin/env ruby

unless (defined?(Rails))
  exec(File.expand_path('../bin/rails', File.dirname(__FILE__)), 'runner', __FILE__, *ARGV)
end
  
require 'optparse'

# == Support Methods ========================================================

def sources
  %w[
    source1
  ]
end

def import!
  sources.each do |source|
    unless (LegacySource.where(name: source).count > 0)
      file = File.expand_path('raw_data/%s.csv' % source, @assets_path)

      puts "Importing #{file}"

      importer = Importer::GenericCsv.new(file, name: source)

      importer.create_legacy_source!
    end
  end

  sources.each do |source|
    # Run extractor to generate extracted_data
    puts "Extracting Data from source #{source}"

    extractor = Legacy::Extractor.extractor_for(source)

    LegacySource.where(name: source).first.legacy_entities.each do |legacy_entity|
      legacy_entity.extracted_data = extractor.call(legacy_entity)

      legacy_entity.save!
    end
    
    # Filter extracted data
    puts "Generating filter for source #{source}"

    legacy_entities = LegacySource.where(name: source).first.legacy_entities

    # Re-order legacy_entities: ego (hoh), ep01 (spouse) then the rest (kids/dependents)
    case (source)
      when 'A01-01-01', 'A19-01-01', 'A19-01-02', 'A19-01-03', 'A19-01-04'
        hohs_and_spouses = 
          legacy_entities.where("(raw_data->>'Parent\u{00E9}') = ?", "ego") + 
          legacy_entities.where("(raw_data->>'Parent\u{00E9}') = ?", "ep01")

        other = legacy_entities - hohs_and_spouses

        legacy_entities = hohs_and_spouses + other
      end

    filtered_entities =
      case (source)
      when 'A01-01-01'
        Legacy::Filter::A010101Filter.new(legacy_entities)
      when 'A19-01-01', 'A19-01-02', 'A19-01-03', 'A19-01-04'
        Legacy::Filter::A190101Filter.new(legacy_entities)
      when 'A01-01-04'
        Legacy::Filter::A010104Filter.new(legacy_entities)
      when 'A19-01-05', 'A19-01-06', 'A19-01-07', 'A19-01-08'
        Legacy::Filter::A190105Filter.new(legacy_entities)
      when 'A01-01-06'
        Legacy::Filter::A010106Filter.new(legacy_entities)
      when 'A16-01-03'
        Legacy::Filter::A160103Filter.new(legacy_entities)
      when 'A17-02-03'
        Legacy::Filter::A170203Filter.new(legacy_entities)
      when 'A17-02-04'
        Legacy::Filter::A170204Filter.new(legacy_entities)
      when 'A19-01-09', 'A19-01-10', 'A19-01-11', 'A19-01-12'
        Legacy::Filter::A190109Filter.new(legacy_entities)
      else
        legacy_entities
      end

    # Pass the filtered data to the importer to create the actual record using the extracted data
    puts "Importing Data from source #{source}"

    filtered_entities.each do |entity|
      Legacy::Importer.new(
        entity
      ).import!
    end
  end
end

# == Main ===================================================================

@assets_path = [ Rails.root.to_path, '/assets/' ].join

parser = OptionParser.new do |parser|
  parser.banner = "Usage: legacy [command] [options]"

  parser.separator("")
  parser.separator("Commands:")
  parser.separator("")
  parser.separator("    import - Import legacy data")
  parser.separator("")
  parser.separator("Options:")
  parser.separator("")

  parser.on('-a', '--assets=s', 'Specify assets path') do |p|
    @assets_path = File.expand_path(p, Dir.getwd)
  end

  parser.on('-h', '--help') do
    puts parser
    exit(0)
  end
end

args = parser.parse(*ARGV)

if (args.empty?)
  puts parser
  exit(0)
end

args.each do |arg|
  case (arg)
  when 'import'
    import!
  else
    STDERR.puts("Unknown command '#{arg}'")
    exit(-1)
  end
end
