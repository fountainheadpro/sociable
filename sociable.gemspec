$LOAD_PATH.unshift 'lib'
require "version"

Gem::Specification.new do |gem|
  gem.name              = "sociable"
  gem.version           = Sociable::VERSION
  gem.date              = Time.now.strftime('%Y-%m-%d')
  gem.summary           = "This gem will make your rails app social in 30 seconds or less."
  gem.homepage          = "https://github.com/actions/sociable"
  gem.email             = "sergey@actions.im"
  gem.authors           = [ "Sergey Zelvenskiy" ]
  gem.has_rdoc          = false

  gem.files             = %w(README)
  gem.files            += Dir.glob("lib/**/*")
  gem.files            += Dir.glob("bin/**/*")
  gem.files            += Dir.glob("man/**/*")
  gem.files            += Dir.glob("test/**/*")
  gem.require_paths = ['lib']

#  s.executables       = %w( sociable )
  gem.description       = "
  Sociable gem provides abilities to share various user actions happening in your app and present these on custom newsfeed.
  The following features can be seamlessly added to your app.
  1. Create user account using Facebook or Twitter profiles.
  2. Invite friends from email address book, facebook, twitter.
  3. Track various events happening in your application.
    It can be anything from uploading new picture to installing new plug-in.
  4. Present user activities on user profile page.
  5. Follow friends activities.
  6. Present configurable newsfeed, which shows timeline of events happening in the app."

  gem.add_dependency("devise", "~> 2.1.2")
  gem.add_dependency("omniauth-facebook", "~> 1.4.0")
  gem.add_dependency("omniauth-twitter", "~> 0.0.12")
  gem.add_dependency("omniauth-linkedin", "~> 0.0.6")
  gem.add_dependency('faraday', '~> 0.8')

end
