# This is a a single Google profile obtained from from XML, parsed into to a hash (by HTTParty/Crack), then output by awesome_print.
#   {
#               "id" => "http://www.google.com/m8/feeds/profiles/domain/redningja.com/full/jared",
#          "updated" => "2011-03-31T15:24:04.179Z",
#       "app:edited" => "2011-03-31T15:24:04.179Z",
#         "category" => {
#           "scheme" => "http://schemas.google.com/g/2005#kind",
#             "term" => "http://schemas.google.com/contact/2008#profile"
#       },
#            "title" => "Jared Ning",
#             "link" => [
#           [0] {
#                "rel" => "http://schemas.google.com/contacts/2008/rel#photo",
#               "type" => "image/*",
#               "href" => "https://www.google.com/m8/feeds/photos/profile/redningja.com/jared"
#           },
#           [1] {
#                "rel" => "self",
#               "type" => "application/atom+xml",
#               "href" => "https://www.google.com/m8/feeds/profiles/domain/redningja.com/full/jared"
#           },
#           [2] {
#                "rel" => "edit",
#               "type" => "application/atom+xml",
#               "href" => "https://www.google.com/m8/feeds/profiles/domain/redningja.com/full/jared"
#           }
#       ],
#          "gd:name" => {
#             "gd:fullName" => "Jared Ning",
#            "gd:givenName" => "Jared",
#           "gd:familyName" => "Ning"
#       },
#         "gd:email" => [
#           [0] {
#                   "rel" => "http://schemas.google.com/g/2005#other",
#               "address" => "jared@redningja.com",
#               "primary" => "true"
#           },
#           [1] {
#                   "rel" => "http://schemas.google.com/g/2005#other",
#               "address" => "*@redningja.com"
#           }
#       ],
#          "gd:etag" => "\"D0NbQR5cQit7I2A4\""
#   }
#
# It is possible for a profile to have multiple email addresses.

class RGData::Model::Profile

  include RGData::Model

  field(:full_name)   { |xml_hash| xml_hash['gd:name']['gd:fullName'] }
  field(:given_name)  { |xml_hash| xml_hash['gd:name']['gd:givenName'] }
  field(:family_name) { |xml_hash| xml_hash['gd:name']['gd:familyName'] }
  field(:emails)      { |xml_hash| [xml_hash['gd:email']].flatten.map { |email| email['address'] } }

end
