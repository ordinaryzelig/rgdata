module MiniTest::Spec::Helpers

  def fixture_file(file_name)
    File.open(ROOT_DIR + 'mspec/fixtures/' + file_name)
  end

end

MiniTest::Unit::TestCase.send :include, MiniTest::Spec::Helpers
