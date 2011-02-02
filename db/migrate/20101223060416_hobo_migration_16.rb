class HoboMigration16 < ActiveRecord::Migration
  def self.up
    add_column :users, :descripcion, :text
  end

  def self.down
    remove_column :users, :descripcion
  end
end
