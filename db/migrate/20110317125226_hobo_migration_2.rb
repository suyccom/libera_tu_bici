class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :peticions, :email, :string
    add_column :peticions, :telefono, :string
  end

  def self.down
    remove_column :peticions, :email
    remove_column :peticions, :telefono
  end
end
