class RGData::Authentication

  include HTTParty
  base_uri 'https://accounts.google.com/o/oauth2'

  class << self

    # Construct a url for requesting authentication.
    def request_url(scope, redirect_uri)
      method = Net::HTTP::Get
      path = default_options[:base_uri] + '/auth'
      query = {
        redirect_uri:  redirect_uri,
        scope:         scope,
        response_type: 'code',
        client_id:     RGData.config.client_id,
      }
      query.verify_keys_present_and_values_not_nil(:client_id, :redirect_uri, :scope, :response_type)
      request = HTTParty::Request.new(method, path, query: query)
      URI.unescape(request.uri.to_s)
    end

    def get_access_token(refresh_token)
      body = {
        refresh_token: refresh_token,
        grant_type: 'refresh_token',
        client_id: RGData.config.client_id,
        client_secret: RGData.config.client_secret,
      }
      body.verify_keys_present_and_values_not_nil(:refresh_token, :grant_type, :client_secret, :client_id)
      response = post('/token', body: body)
      response['access_token']
    end

  end

end
