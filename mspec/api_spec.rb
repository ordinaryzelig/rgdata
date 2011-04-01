require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'

describe RGData::API do

  it 'extracts oauth_token or access_token or gets one using refresh_token' do
    klass = Class.new
    klass.extend RGData::API::ClassMethods
    klass.send(:extract_oauth_token_or_access_token_or_get_one_using_refresh_token, oauth_token: 'asdf').must_equal 'asdf'
    klass.send(:extract_oauth_token_or_access_token_or_get_one_using_refresh_token, access_token: 'asdf').must_equal 'asdf'
    klass.send(:extract_oauth_token_or_access_token_or_get_one_using_refresh_token, refresh_token: TEST_REFRESH_TOKEN).wont_be_nil
  end

end
