require "spec_helper"


describe "find or create user based on facebook oauth" do

  before :all do
    class User
      include Mongoid::Document
      include Sociable::Profile::Facebook::Mongoid
    end
  end

  it "should lookup user by access token" do
    user=User.find_for_facebook_oauth(facebook_auth_hash, 1)
    User.count.should eq(1)
    User.first[:email].should eq facebook_auth_hash[:info][:email]
    user.id.should_not be nil

  end

  it "should save facebook information for existing user" do
    true.should == false
  end

  it "should create new user based on the information coming from facebook" do
    true.should == false
  end

end