class HoboMigration5 < ActiveRecord::Migration
  def self.up
    rename_column :peticions, :lifecycle_state, :estado

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
    add_index :peticions, [:estado]
  end

  def self.down
    rename_column :peticions, :estado, :lifecycle_state

    remove_index :peticions, :name => :index_peticions_on_estado rescue ActiveRecord::StatementInvalid
    add_index :peticions, [:lifecycle_state]
  end
end
