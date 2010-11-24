class HoboMigration6 < ActiveRecord::Migration
  def self.up
    drop_table :mensajes

    add_column :peticions, :mensaje, :text

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :peticions, :mensaje

    create_table "mensajes", :force => true do |t|
      t.text     "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
      t.integer  "peticion_id"
    end

    add_index "mensajes", ["peticion_id"], :name => "index_mensajes_on_peticion_id"
    add_index "mensajes", ["user_id"], :name => "index_mensajes_on_user_id"

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
