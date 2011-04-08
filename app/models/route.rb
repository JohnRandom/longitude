class Route < ActiveRecord::Base
  belongs_to :user
  has_many :locations, :as => :entity, :dependent => :destroy

  # validations
  validates_presence_of :user_id
  validates_presence_of :name
end
