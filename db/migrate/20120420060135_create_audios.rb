class CreateAudios < ActiveRecord::Migration
  def self.up
    create_table :audios do |t|
      t.string :username
      t.binary :data

      t.timestamps
    end
  end

  def self.down
    drop_table :audios
  end
end
