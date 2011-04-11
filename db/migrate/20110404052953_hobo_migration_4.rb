class HoboMigration4 < ActiveRecord::Migration
  def self.up
    add_column :direccions, :foto_entrega_file_name, :string
    add_column :direccions, :foto_entrega_content_type, :string
    add_column :direccions, :foto_entrega_file_size, :integer
    add_column :direccions, :foto_entrega_updated_at, :datetime
  end

  def self.down
    remove_column :direccions, :foto_entrega_file_name
    remove_column :direccions, :foto_entrega_content_type
    remove_column :direccions, :foto_entrega_file_size
    remove_column :direccions, :foto_entrega_updated_at
  end
end
