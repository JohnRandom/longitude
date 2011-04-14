require 'spec_helper'
require 'database_cleaner'

describe Route do
  before(:each) do
    @user = User.make!
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  # it's mostly to learn some machinist stuff, most of the specs here are not that useful
  describe 'creation' do
    it 'should validate :name and :user_id' do
      Route.create.should have(1).error_on(:name)
      Route.create.should have(1).error_on(:user_id)
      Route.should have(:no).records
    end

    it 'should create valid records' do
      route = Route.make! name: 'test_route'
      Route.should have(1).record
    end

    it 'should not be allowed to provide a user_id' do
      Route.create(name: 'test', user_id: 1).should have(1).error_on(:user_id)
    end
  end

  describe 'deletion' do
    it 'should remove the route from the DB' do
      route = Route.make! name: 'test_route'
      Route.should have(1).record

      route.destroy
      Route.should have(:no).records
    end

    it 'should delete all attached locations as well' do
      route = @user.routes.create name: 'test_route'
      route.locations.create! latitude: 1.0, longitude: 1.0
      Location.should have(1).record

      route.destroy
      Location.should have(:no).records
    end
  end

  describe 'locations' do
    it 'should return locations' do
      route = Route.make!
      route.locations.create latitude: 1.0, longitude: 1.0

      route.locations.should_not be_empty
    end
  end
end
