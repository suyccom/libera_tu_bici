class HoboMigration8 < ActiveRecord::Migration
  def self.up
    remove_column :users, :email_address

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :users, :email_address, :string

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
