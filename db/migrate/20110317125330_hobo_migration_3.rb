class HoboMigration3 < ActiveRecord::Migration
  def self.up
    remove_column :peticions, :telefono
  end

  def self.down
    add_column :peticions, :telefono, :string
  end
end
