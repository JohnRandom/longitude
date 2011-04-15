require 'spec_helper'
require 'database_cleaner'
require 'bcrypt'

describe Location do
  before :each do
    @route = Route.make!
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'creation' do
    it 'should validate latitude, longitude, entity_id and entity_type' do
      Location.create.should have(1).error_on(:latitude)
      Location.create.should have(1).error_on(:longitude)
      Location.create.should have(1).error_on(:entity_id)
      Location.should have(:no).records
    end

    it 'should only make latitude and longitude accessible' do
      Location.create(entity_id: 1).should have(1).error_on(:entity_id)
      Location.should have(:no).records
    end
  end

  describe 'deletion' do
    it 'should not delete associated routes' do
      location = @route.locations.create! latitude: 1.0, longitude: 1.0
      Location.should have(1).record

      location.destroy
      Location.should have(:no).records
      Route.should have(1).record
    end
  end
end
