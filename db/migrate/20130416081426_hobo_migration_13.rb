class HoboMigration13 < ActiveRecord::Migration
  def self.up
    add_column :direccions, :latitude, :float
    add_column :direccions, :longitude, :float

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :direccions, :latitude
    remove_column :direccions, :longitude

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
