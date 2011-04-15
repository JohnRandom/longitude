require 'spec_helper'
require 'database_cleaner'

describe User do
  before :each do
    @password = 'test'
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'creation' do
    it 'should validate presence of email and password' do
      User.create.should have(1).error_on(:email)
      User.create.should have(1).error_on(:password)
      User.should have(:no).records
    end

    it 'should generate a password and salt hash using bcrypt' do
      user = User.make! password: @password, password_confirmation: @password
      user.password_hash.should_not == nil
      user.password_hash.should == BCrypt::Engine.hash_secret(@password, user.password_salt)
    end
  end

  describe 'authentication' do
    it 'should authenticate registered users' do
      user = User.make! password: @password, password_confirmation: @password
      User.authenticate(user.email, @password).should == user
    end

    it 'should not authenticate unregistered users' do
      User.authenticate('not_registered@user.de', 'some-password').should == nil
    end

    it 'should not authenticate registered users with wrong passwords' do
      user = User.make! password: @password, password_confirmation: @password
      User.authenticate(user.email, @password + '_').should == nil
    end
  end
end
