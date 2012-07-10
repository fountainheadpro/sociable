module Sociable
  module Profile
    module LinkedIn
      module Mongoid
        extend ActiveSupport::Concern

        included do
          # linkedin fields
          field :linkedin_user_name,              :type => String
          field :linkedin_image_url,              :type => String
          field :linkedin_data, :type => Hash
          field :linkedin_token, :type => String
          field :linkedin_token_expiration, :type => String
          attr_accessible :linkedin_user_name, :linkedin_image_url, :linkedin_data, :current_sign_in_ip

        end

        module ClassMethods

          def find_for_linkedin_oauth(access_token, ip)
            data = access_token.info
            #credentials=access_token.credentials.merge(type: :linkedin)
            users_criteria = self.any_of({ linkedin_user_name: data.nickname }, { last_sign_in_ip: ip, name: data.name })
            if users_criteria.count > 0
              user = users_criteria.first
              user.credentials ||= {}
              user.credentials.merge!(linkedin: access_token.credentials)
              user.update_attributes(linkedin_user_name: data.nickname,
                                     linkedin_data: access_token.extra.raw_info,
                                     linkedin_image_url: data.image) unless (user.linkedin_user_name)
              user.update_attribute(email: data.email) unless user.email
              user
            else
              user=self.create!(
                  password: Devise.friendly_token[0,20],
                  linkedin_image_url: data.image,
                  linkedin_user_name: data.nickname,
                  name: data.name,
                  email: data.email,
                  linkedin_data: access_token.extra.raw_info,
                  credentials: credentials
              )
              user.save!
              user
            end
          end
        end

        module InstanceMethods

          def new_with_session(params, session)
            super.tap do |user|
              if data = session["devise.linkedin_data"] && session["devise.linkedin_data"]["info"]
                user.linkedin_user_name = data["nickname"]
              end
            end
          end

        end

      end

      module ActiveRecord

      end

    end
  end
end