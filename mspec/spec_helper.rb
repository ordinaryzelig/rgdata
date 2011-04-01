require 'minitest/pride'
require 'minitest/autorun'
require 'pathname'
ROOT_DIR = Pathname(File.dirname(File.expand_path(__FILE__))) + '..'
$LOAD_PATH << (ROOT_DIR + 'lib').to_s
require 'rgdata'
require 'crack'

RGData.config do
  client_id     ENV['GOOGLE_APPS_CLIENT_ID']
  client_secret ENV['GOOGLE_APPS_CLIENT_SECRET']
end
TEST_REFRESH_TOKEN = ENV['GOOGLE_APPS_REFRESH_TOKEN']

module MiniTest::Spec::Helpers

  def fixture_file(file_name)
    File.open(ROOT_DIR + 'mspec/fixtures/' + file_name)
  end

end

MiniTest::Unit::TestCase.send :include, MiniTest::Spec::Helpers
