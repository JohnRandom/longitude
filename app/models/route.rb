class Route < ActiveRecord::Base
  belongs_to :user
  has_many :locations, :as => :entity, :dependent => :destroy

  # validations
  validate :user_id, :presence => true
  validate :name, :presence => true
end
