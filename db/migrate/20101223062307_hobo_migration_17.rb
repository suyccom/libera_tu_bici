class HoboMigration17 < ActiveRecord::Migration
  def self.up
    add_column :peticions, :user_id, :integer

    add_index :peticions, [:user_id]
  end

  def self.down
    remove_column :peticions, :user_id

    remove_index :peticions, :name => :index_peticions_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
