class HoboMigration9 < ActiveRecord::Migration
  def self.up
    drop_table :bicicletas

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    create_table "bicicletas", :force => true do |t|
      t.string   "name"
      t.string   "lugar"
      t.text     "descripcion"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "estado",        :default => "disponible"
      t.datetime "key_timestamp"
    end

    add_index "bicicletas", ["estado"], :name => "index_bicicletas_on_estado"

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
