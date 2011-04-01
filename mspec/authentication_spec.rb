require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'

describe RGData::Authentication do

  it 'provides a url for a user to request authentication' do
    scope        = RGData::API::Profiles.scope
    redirect_uri = 'http://come.back.here.after.successful.authentication.com/'
    request_url = RGData::Authentication.request_url(scope, redirect_uri)
    uri = URI.escape("https://accounts.google.com/o/oauth2/auth?client_id=#{RGData.config.client_id}&redirect_uri=http://come.back.here.after.successful.authentication.com/&scope=http://www.google.com/m8/feeds/&response_type=code")
    request_url.must_equal uri
  end

  it 'swaps a refresh_token for a hash with access_token and expiration' do
    response = RGData::Authentication.swap_refresh_token(TEST_REFRESH_TOKEN)
    response.must_have_response_keys ['access_token', 'expires_in']
  end

  # This must be tested live because you have to contact Google through a web interface to get an authorization code.
  # Remember, you only get 1 shot with this authorization code. Once it is sent to Google, it's expired.
  # I setup a Sinatra app that makes it easy to request authorization codes. I will include it later.
  it 'swaps an authorization_code for a hash with access_token, refresh_token, and expiration' do
    unless TEST_AUTHORIZATION_CODE
      skip 'This must be tested with a valid authorization code and registered redirect_uri.'
    end
    response = RGData::Authentication.swap_authorization_code(TEST_AUTHORIZATION_CODE, TEST_REDIRECT_URI)
    response.must_have_response_keys ['access_token', 'expires_in', 'refresh_token']
  end

end
