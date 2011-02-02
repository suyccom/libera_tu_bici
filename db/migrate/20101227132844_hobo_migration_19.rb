class HoboMigration19 < ActiveRecord::Migration
  def self.up
    rename_column :peticions, :owner_id, :user_id

    remove_index :peticions, :name => :index_peticions_on_owner_id rescue ActiveRecord::StatementInvalid
    remove_index :peticions, :name => :index_peticions_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :peticions, [:user_id]
  end

  def self.down
    rename_column :peticions, :user_id, :owner_id

    remove_index :peticions, :name => :index_peticions_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :peticions, [:owner_id]
    add_index :peticions, [:owner_id], :name => 'index_peticions_on_user_id'
  end
end
