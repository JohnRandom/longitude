class RemoveUserIdColumnFromLocation < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.remove :user_id
    end
  end

  def self.down
    change_table :locations do |t|
      t.integer :user_id
    end
  end
end
