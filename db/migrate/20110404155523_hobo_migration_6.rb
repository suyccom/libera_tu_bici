class HoboMigration6 < ActiveRecord::Migration
  def self.up
    add_column :users, :disponible, :boolean, :default => true

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :users, :disponible

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
