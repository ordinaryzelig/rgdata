# A class that includes RGData::Model represent an XML response from GOogle as a Ruby object.
# The class method new_from_xml_hash accepts an XML hash.
# It should be the portion of the HTTParty/Crack parsed hash that represents a single record.
# Once the module is included, the class just needs to declare fields and
# define instructions on how to drill down into the hash to get to the useful information.

module RGData::Model

  def self.included(target)
    target.extend ClassMethods
  end

  module ClassMethods

    # Declare a field.
    # It will be given attr_accessor.
    # parse_block will be instructions on how to drill down into the xml_hash and get the value.
    def field(name, &parse_block)
      parse_blocks[name] = parse_block
      attr_accessor name
    end

    def new_from_xml_hash(xml_hash)
      attributes = parse_blocks.inject({}) do |atts, (field, parse_block)|
        begin
          atts[field] = parse_block.call(xml_hash)
          atts
        rescue Exception => ex
          raise FieldError.new(field, ex.message)
        end
      end
      new(attributes)
    end

    private

    def parse_blocks
      @parse_blocks ||= {}
    end

  end

  def initialize(atts = {})
    atts.each do |field, value|
      send "#{field}=", value
    end
  end

  class FieldError < StandardError
    def initialize(field, msg)
      super "Error extracting '#{field}' field value from xml_hash: #{msg}"
    end
  end

end
