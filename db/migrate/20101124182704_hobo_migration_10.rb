class HoboMigration10 < ActiveRecord::Migration
  def self.up
    add_column :bicicletas, :estado, :string, :default => "disponible"
    add_column :bicicletas, :key_timestamp, :datetime

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :bicicletas, [:estado]
  end

  def self.down
    remove_column :bicicletas, :estado
    remove_column :bicicletas, :key_timestamp

    remove_index :bicicletas, :name => :index_bicicletas_on_estado rescue ActiveRecord::StatementInvalid
    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
