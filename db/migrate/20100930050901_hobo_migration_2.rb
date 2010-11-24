class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :bicicletas, :user_id, :integer

    add_index :bicicletas, [:user_id]
  end

  def self.down
    remove_column :bicicletas, :user_id

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
