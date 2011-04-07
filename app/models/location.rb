class Location < ActiveRecord::Base
  belongs_to :routes
  validate :latitude, :presence => true
  validate :longitude, :presence => true
end
