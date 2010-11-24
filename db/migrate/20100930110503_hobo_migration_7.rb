class HoboMigration7 < ActiveRecord::Migration
  def self.up
    add_column :peticions, :lifecycle_state, :string, :default => "esperando"
    add_column :peticions, :key_timestamp, :datetime

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid

    add_index :peticions, [:lifecycle_state]
  end

  def self.down
    remove_column :peticions, :lifecycle_state
    remove_column :peticions, :key_timestamp

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end
end
