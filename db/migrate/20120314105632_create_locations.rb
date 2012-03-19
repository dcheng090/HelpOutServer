class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :number
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
