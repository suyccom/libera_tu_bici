class HoboMigration11 < ActiveRecord::Migration
  def self.up
    add_column :users, :telefono, :string

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :users, :telefono

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
