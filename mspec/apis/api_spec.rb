require File.dirname(File.expand_path(__FILE__)) + '/../spec_helper'

describe RGData::API do

  before :each do
    @klass = Class.new
    @klass.send :include, RGData::API
  end

  it 'stores and returns scope' do
    @klass.scope = 'asdf'
    @klass.scope.must_equal 'asdf'
  end

end
