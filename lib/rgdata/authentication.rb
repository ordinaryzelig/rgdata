class RGData::Authentication

  include HTTParty
  base_uri 'https://accounts.google.com/o/oauth2'

  class << self

    # Construct a url for requesting authentication.
    def request_url(scope, redirect_uri)
      method = Net::HTTP::Get
      path = default_options[:base_uri] + '/auth'
      query = {
        client_id:     RGData.config.client_id,
        redirect_uri:  redirect_uri,
        scope:         scope,
        response_type: 'code',
      }
      query.verify_keys_present_and_values_not_blank(:client_id, :redirect_uri, :scope, :response_type)
      request = HTTParty::Request.new(method, path, query: query)
      URI.unescape(request.uri.to_s)
    end

    def swap_authorization_code(authorization_code, redirect_uri)
      body = {
        client_id:      RGData.config.client_id,
        client_secret:  RGData.config.client_secret,
        code:           authorization_code,
        grant_type:     'authorization_code',
        redirect_uri:   redirect_uri
      }
      body.verify_keys_present_and_values_not_blank(:client_secret, :client_id, :code, :grant_type, :redirect_uri)
      post('/token', body: body)
    end

    def swap_refresh_token(refresh_token)
      body = {
        client_id:      RGData.config.client_id,
        client_secret:  RGData.config.client_secret,
        refresh_token:  refresh_token,
        grant_type:     'refresh_token',
      }
      body.verify_keys_present_and_values_not_blank(:refresh_token, :grant_type, :client_secret, :client_id)
      post('/token', body: body)
    end

  end

end
