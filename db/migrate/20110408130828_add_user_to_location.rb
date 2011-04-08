class AddUserToLocation < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.references :user
    end
  end

  def self.down
    alter_table :locations do |t|
      t.remove :user_id
    end
  end
end
