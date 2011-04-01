require File.dirname(File.expand_path(__FILE__)) + '/../spec_helper'

describe RGData::Model::Profile do

  it 'can be created from an xml hash' do
    data = [
      ['Jared Ning', 'Jared', 'Ning', ['jared@redningja.com', '*@redningja.com']],
      ['jared weining', 'jared', 'weining', ['jwn@redningja.com']],
      ['darcy clark', 'darcy', 'clark', ['darcy@redningja.com']],
      ['stephanie adler', 'stephanie', 'adler', ['stephanie@redningja.com']],
    ]
    xml_hashes = Crack::XML.parse(fixture_file('profiles.xml'))['feed']['entry']
    xml_hashes.map do |xml_hash|
      profile = RGData::Model::Profile.new_from_xml_hash(xml_hash)
      profile_data = [:full_name, :given_name, :family_name, :emails].map { |field| profile.send field }
      profile_data
    end.must_equal data
  end

end
