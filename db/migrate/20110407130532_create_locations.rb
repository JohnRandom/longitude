class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.references :entity, :polymorphic => {:default => :route}

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :locations
  end
end
