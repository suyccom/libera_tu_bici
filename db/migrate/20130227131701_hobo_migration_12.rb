class HoboMigration12 < ActiveRecord::Migration
  def self.up
    create_table :textos do |t|
      t.string   :name
      t.text     :texto
      t.datetime :created_at
      t.datetime :updated_at
    end

    remove_index :peticions, :name => :index_peticions_on_lifecycle_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :textos

    add_index :peticions, [:estado], :name => 'index_peticions_on_lifecycle_state'
  end
end
