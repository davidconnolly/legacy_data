class Legacy::Filter::SampleSourceFilter < Legacy::Filter
  def allow?(record)
    fields = {}

    fields["name"] = record.raw_data["name"]

    if 
      (
        fields["name"]
      )
      true
    else
      record.error_data = record.error_data.merge(
        MISSING_DATA: "There are fields with missing or invalid data",
        INVALID_FIELDS: format_field_errors(fields)
      )

      record.save!
      
      alert("ERROR: Raw data of Legacy Entity #{record.id} is missing required data")

      false
    end
  end
end
