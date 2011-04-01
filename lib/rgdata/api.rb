module RGData::API

  def self.included(target)
    target.extend ClassMethods
    target.instance_eval do
      include HTTParty
      headers 'GData-Version' => '3.0'
      format :xml
    end
  end

  module ClassMethods

    attr_accessor :scope
    attr_accessor :model

    def request_url(redirect_uri)
      RGData::Authentication.request_url(scope, redirect_uri)
    end

    # Send request and return response.
    # options can be :oauth_token, :access_token, or :refresh_token.
    def do_request(domain, options)
      oauth_token = extract_oauth_token_or_access_token_or_get_one_using_refresh_token(options)
      query = {oauth_token: oauth_token}
      query.verify_keys_present_and_values_not_nil(:oauth_token)
      get "/#{domain}/full", query: query
    end

    # Perform request and instantiate new model objects.
    def retrieve(domain, options)
      full_xml_hash = do_request(domain, options)
      full_xml_hash['feed']['entry'].map do |xml_hash|
        model.new_from_xml_hash xml_hash
      end
    end

    private

    # Get an oauth_token from a hash.
    # It can be in the form of oauth_token or access_token.
    # If neither of those is found, refresh_token should be present and
    # will be used to get an access_token.
    def extract_oauth_token_or_access_token_or_get_one_using_refresh_token(hash)
      oauth_token = hash.extract_values_at(:oauth_token, :access_token).compact.first
      unless oauth_token
        refresh_token = hash.extract(:refresh_token)
        oauth_token = RGData::Authentication::get_access_token(refresh_token)
      end
      oauth_token
    end

  end

end
