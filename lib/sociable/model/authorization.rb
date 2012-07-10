module Sociable
  module Profile

    module Authorization
      extend ActiveSupport::Concern

      included do
        field :credentials, :type => Hash
        field :profile_image_url, :type => String
        attr_accessible :credentials, :profile_image_url
      end

    end

  end
end