class HoboMigration15 < ActiveRecord::Migration
  def self.up
    add_column :users, :direccion_activa_id, :integer

    add_index :users, [:direccion_activa_id]
  end

  def self.down
    remove_column :users, :direccion_activa_id

    remove_index :users, :name => :index_users_on_direccion_activa_id rescue ActiveRecord::StatementInvalid
  end
end
