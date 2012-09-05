require 'active_support/core_ext'

module Sociable

  module Profile
    autoload :Facebook, 'sociable/model/facebook'
    autoload :Twitter, 'sociable/model/twitter'
    autoload :LinkedIn, 'sociable/model/linkedin'
    autoload :Authorization, 'sociable/model/authorization'
  end

  mattr_accessor :twitter_omniauth_settings

  mattr_accessor :facebook_omniauth_settings

  mattr_accessor :linkedin_omniauth_settings

  def self.twitter (*args)
    @twitter_omniauth_settings=["twitter"]
    @twitter_omniauth_settings+=args
  end

  def self.facebook (*args)
    @facebook_omniauth_settings=["facebook"]
    @facebook_omniauth_settings+=args
  end

  def self.linkedin (*args)
    @linkedin_omniauth_settings=["linkedin"]
    @linkedin_omniauth_settings+=args
  end

  def self.setup
    yield self

    Devise.setup do |config|

      config.send(:omniauth, *@twitter_omniauth_settings) if @twitter_omniauth_settings

      config.send(:omniauth, *@facebook_omniauth_settings) if @facebook_omniauth_settings

      config.send(:omniauth, *@linkedin_omniauth_settings) if @linkedin_omniauth_settings

    end
  end

end
