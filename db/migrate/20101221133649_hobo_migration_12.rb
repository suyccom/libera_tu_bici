class HoboMigration12 < ActiveRecord::Migration
  def self.up
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

    remove_column :bicicletas, :foto_file_size
    remove_column :bicicletas, :owner_id
    remove_column :bicicletas, :foto_content_type
    remove_column :bicicletas, :foto_file_name
    remove_column :bicicletas, :foto_updated_at

    remove_column :peticions, :owner_id
    remove_column :peticions, :bicicleta_id

    add_column :users, :foto_file_name, :string
    add_column :users, :foto_content_type, :string
    add_column :users, :foto_file_size, :integer
    add_column :users, :foto_updated_at, :datetime
    remove_column :users, :telefono
    remove_column :users, :email_address

    remove_index :bicicletas, :name => :index_bicicletas_on_owner_id rescue ActiveRecord::StatementInvalid
    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid

    remove_index :peticions, :name => :index_peticions_on_bicicleta_id rescue ActiveRecord::StatementInvalid
    remove_index :peticions, :name => :index_peticions_on_owner_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :bicicletas, :foto_file_size, :integer
    add_column :bicicletas, :owner_id, :integer
    add_column :bicicletas, :foto_content_type, :string
    add_column :bicicletas, :foto_file_name, :string
    add_column :bicicletas, :foto_updated_at, :datetime

    add_column :peticions, :owner_id, :integer
    add_column :peticions, :bicicleta_id, :integer

    remove_column :users, :foto_file_name
    remove_column :users, :foto_content_type
    remove_column :users, :foto_file_size
    remove_column :users, :foto_updated_at
    add_column :users, :telefono, :string
    add_column :users, :email_address, :string

    drop_table :direccions

    add_index :bicicletas, [:owner_id]
    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'

    add_index :peticions, [:bicicleta_id]
    add_index :peticions, [:owner_id]
  end
end
