class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :bicicletas do |t|
      t.string   :name
      t.string   :lugar
      t.text     :descripcion
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :estado, :default => "disponible"
      t.datetime :key_timestamp
    end
    add_index :bicicletas, [:estado]

    create_table :direccions do |t|
      t.string   :email
      t.string   :direccion
      t.string   :telefono
      t.date     :fecha_alta
      t.date     :fecha_baja
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :direccions, [:user_id]

    create_table :peticions do |t|
      t.text     :mensaje
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.string   :lifecycle_state, :default => "esperando"
      t.datetime :key_timestamp
    end
    add_index :peticions, [:user_id]
    add_index :peticions, [:lifecycle_state]

    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.text     :descripcion
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :direccion_activa_id
      t.string   :foto_file_name
      t.string   :foto_content_type
      t.integer  :foto_file_size
      t.datetime :foto_updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    add_index :users, [:direccion_activa_id]
    add_index :users, [:state]
  end

  def self.down
    drop_table :bicicletas
    drop_table :direccions
    drop_table :peticions
    drop_table :users
  end
end
