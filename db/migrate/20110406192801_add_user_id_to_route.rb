class AddUserIdToRoute < ActiveRecord::Migration
  def self.up
    change_table :routes do |t|
      t.remove :user
      t.references :user
    end
  end

  def self.down
    change_table :routes do |t|
      t.string :user
      t.remove :user_id
    end
  end
end
