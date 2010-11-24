class HoboMigration3 < ActiveRecord::Migration
  def self.up
    rename_column :bicicletas, :user_id, :owner_id

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :bicicletas, [:owner_id]
  end

  def self.down
    rename_column :bicicletas, :owner_id, :user_id

    remove_index :bicicletas, :name => :index_bicicletas_on_owner_id rescue ActiveRecord::StatementInvalid
    add_index :bicicletas, [:user_id]
  end
end
