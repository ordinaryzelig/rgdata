# http://code.google.com/googleapps/domain/profiles/developers_guide_protocol.html
# Authentication notes:
#   Google requires that the user granting permission be an administrator for their domain.
#   When prompted for which account they are going to use, they should choose the one under the Google Apps section (not the default one).

module RGData::API

  class Profiles

    include RGData::API

    base_uri     'http://www.google.com/m8/feeds/profiles/domain'
    self.scope = 'http://www.google.com/m8/feeds/'
    self.model = RGData::Model::Profile

  end

end
