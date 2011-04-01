require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'

describe RGData::Config do

  after :each do
    # Restore configs.
    RGData.config do
      client_id     ENV['GOOGLE_APPS_CLIENT_ID']
      client_secret ENV['GOOGLE_APPS_CLIENT_SECRET']
    end
  end

  it 'stores and returns client_id and client_secret' do
    RGData.config do
      client_id 1
      client_secret 2
    end
    RGData.config.client_id.must_equal 1
    RGData.config.client_secret.must_equal 2
  end

end
