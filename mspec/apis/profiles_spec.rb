require File.dirname(File.expand_path(__FILE__)) + '/../spec_helper'

describe RGData::API::Profiles do

  it 'has a scope' do
    RGData::API::Profiles.scope.wont_be_nil
  end

  it 'requests authentication url' do
    redirect_uri = 'http://come.back.here.after.successful.authentication.com/'
    request_url = RGData::API::Profiles.request_url(redirect_uri)
    uri = URI.escape("https://accounts.google.com/o/oauth2/auth?client_id=#{RGData.config.client_id}&redirect_uri=http://come.back.here.after.successful.authentication.com/&scope=http://www.google.com/m8/feeds/&response_type=code")
    request_url.must_equal uri
  end

  it 'retrieves profiles from a domain' do
    profiles = RGData::API::Profiles.retrieve(TEST_DOMAIN, refresh_token: TEST_REFRESH_TOKEN)
    profiles.wont_be_empty
  end

  it 'has a corresponding model' do
    RGData::API::Profiles.model.must_equal RGData::Model::Profile
  end

end
