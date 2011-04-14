class Location < ActiveRecord::Base
  belongs_to :routes

  attr_accessible :latitude, :longitude

  validates_presence_of :latitude, :longitude, :entity_id, :entity_type
end
