class HoboMigration11 < ActiveRecord::Migration
  def self.up
    add_column :users, :devuelta, :boolean, :default => false

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :users, :devuelta

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
