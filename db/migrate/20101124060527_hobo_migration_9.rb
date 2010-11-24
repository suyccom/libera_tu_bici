class HoboMigration9 < ActiveRecord::Migration
  def self.up
    add_column :bicicletas, :foto_file_name, :string
    add_column :bicicletas, :foto_content_type, :string
    add_column :bicicletas, :foto_file_size, :integer
    add_column :bicicletas, :foto_updated_at, :datetime

    remove_index :bicicletas, :name => :index_bicicletas_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :bicicletas, :foto_file_name
    remove_column :bicicletas, :foto_content_type
    remove_column :bicicletas, :foto_file_size
    remove_column :bicicletas, :foto_updated_at

    add_index :bicicletas, [:owner_id], :name => 'index_bicicletas_on_user_id'
  end
end
