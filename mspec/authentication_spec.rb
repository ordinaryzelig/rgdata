require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'

describe RGData::Authentication do

  it 'provides a url for a user to request authentication' do
    scope        = RGData::API::Profiles.scope
    redirect_uri = 'http://come.back.here.after.successful.authentication.com/'
    request_url = RGData::Authentication.request_url(scope, redirect_uri)
    uri = URI.escape("https://accounts.google.com/o/oauth2/auth?redirect_uri=http://come.back.here.after.successful.authentication.com/&scope=http://www.google.com/m8/feeds/&response_type=code&client_id=#{RGData.config.client_id}")
    request_url.must_equal uri
  end

  it 'retrieves another access_token given a refresh_token' do
    RGData::Authentication.get_access_token(TEST_REFRESH_TOKEN).wont_be_nil
  end

end
