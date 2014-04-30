class Legacy::Filter < Enumerator
  # == Instance Methods =====================================================
  
  def initialize(set)
    # Set up the Enumerator with no arguments, avoid passing `set` in.
    super() do |y|
      # Iterate over all elements in the set...
      set.each do |e|
        # ...and if allowed...
        if (allow?(e))
          # ...include this in the enumeration.
          y << e
        end
      end
    end
  end

  # Customize this method in a sub-class to implement the filtering, do
  # whatever you need to do here to give a true/false answer.
  def allow?(record)
    true
  end

protected
  def alert(message)
    STDERR.puts(message)
    Rails.logger.debug(message)
  end

  def format_field_errors(fields)
    error_messages = {}
    
    fields.each do |key, value|
      if (!value)
        error_messages.merge!("#{key}" => "Field(s) contain missing or invalid data")
      end              
    end

    (error_messages.size > 0) ? error_messages : nil
  end
end
