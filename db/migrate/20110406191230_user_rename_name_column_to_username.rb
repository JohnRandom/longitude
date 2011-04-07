class UserRenameNameColumnToUsername < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename :name, :username
    end
  end

  def self.down
    change_table :users do |t|
      t.rename :username, :name
    end
  end
end
