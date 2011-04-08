class Location < ActiveRecord::Base
  belongs_to :routes

  validates_presence_of :latitude
  validates_presence_of :longitude
end
