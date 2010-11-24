class HoboMigration8 < ActiveRecord::Migration
  def self.up
    add_column :bicicletas, :descripcion, :text

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :bicicletas, :descripcion

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
