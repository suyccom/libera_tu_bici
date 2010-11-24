class HoboMigration4 < ActiveRecord::Migration
  def self.up
    create_table :peticions do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :owner_id
      t.integer  :bicicleta_id
    end
    add_index :peticions, [:owner_id]
    add_index :peticions, [:bicicleta_id]

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :peticions

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
