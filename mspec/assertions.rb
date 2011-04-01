module MiniTest::Assertions

  def assert_has_keys(hash, keys, msg = nil)
    missing_keys = keys.select { |key| !hash.has_key?(key) }
    assert hash.is_a?(Hash), msg || "Exepcted Hash, got: #{mu_pp(hash)}"
    assert missing_keys.none?, msg || "Hash missing keys: #{missing_keys.join(',')}"
  end
  Object.infect_an_assertion :assert_has_keys, :must_have_keys, true

  def assert_httparty_response_has_keys(response, keys, msg = nil)
    assert_has_keys response, keys, msg || "Unexpected response: #{response}"
  end
  Object.infect_an_assertion :assert_httparty_response_has_keys, :must_have_response_keys, true

end
