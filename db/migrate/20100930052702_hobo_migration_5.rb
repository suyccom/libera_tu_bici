class HoboMigration5 < ActiveRecord::Migration
  def self.up
    create_table :mensajes do |t|
      t.text     :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :peticion_id
    end
    add_index :mensajes, [:user_id]
    add_index :mensajes, [:peticion_id]

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :mensajes

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
