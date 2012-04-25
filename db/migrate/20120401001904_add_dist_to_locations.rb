class AddDistToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :dist, :float
  end

  def self.down
    remove_column :locations, :dist
  end
end
