class HoboMigration10 < ActiveRecord::Migration
  def self.up
    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
