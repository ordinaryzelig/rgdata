require 'minitest/pride'
require 'minitest/autorun'
require 'awesome_print'

require 'pathname'
ROOT_DIR = Pathname(File.dirname(File.expand_path(__FILE__))) + '..'
$LOAD_PATH << (ROOT_DIR + 'lib').to_s

require 'rgdata'
require 'crack'

$LOAD_PATH << (ROOT_DIR + 'mspec').to_s
require 'helpers'
require 'assertions'

# Set these in your environment.
RGData.config do
  client_id     ENV['GOOGLE_APPS_CLIENT_ID']
  client_secret ENV['GOOGLE_APPS_CLIENT_SECRET']
end
TEST_REFRESH_TOKEN = ENV['GOOGLE_APPS_REFRESH_TOKEN']
TEST_DOMAIN        = ENV['GOOGLE_APPS_DOMAIN']
TEST_REDIRECT_URI  = ENV['GOOGLE_REDIRECT_URI'] # THIS URI HAS TO BE REGISTERED WITH GOOGLE.
# Test with authorization code? (See authorization_spec.rb test for more info on testing this.)
authorization_code_arg = ARGV.detect { |arg| arg.start_with?('AUTHORIZATION_CODE') }
TEST_AUTHORIZATION_CODE = authorization_code_arg ? /AUTHORIZATION_CODE=(?<code>.*)/.match(authorization_code_arg)[:code] : nil
