require 'httparty'

module RGData
end

require 'rgdata/config'
require 'rgdata/authentication'
require 'rgdata/api'
require 'rgdata/model'

lib_requires = [
  '/support/**/*.rb',
  '/rgdata/models/**/*.rb',
  '/rgdata/apis/**/*.rb',
]
lib_requires.each do |lib|
  Dir[File.dirname(File.expand_path(__FILE__)) + lib].each { |file| require file }
end
