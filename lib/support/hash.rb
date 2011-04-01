class Hash

  # This gem was meant to help deal with the strictness of APIs
  # and their inability to give good feedback for mundane detail errors.
  # This method helps eliminate guessing when it comes to Request query/body/etc. hashes.
  def verify_keys_present_and_values_not_nil(*keys)
    keys.each do |key|
      unless has_key?(key.to_sym) || has_key?(key.to_s)
        raise "Options missing '#{key}'"
      end
      if extract(key).nil?
        raise "Option '#{key}' cannot be nil"
      end
    end
  end

  # get a value from the given key whether it be stored as a symbol or string.
  def extract(key)
    self[key.to_s] || self[key.to_sym]
  end

  # Same as values_at(), but uses extract().
  def extract_values_at(*keys)
    keys.map { |key| extract(key) }
  end

end
