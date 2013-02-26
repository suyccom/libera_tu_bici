# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130222091024) do

  create_table "direccions", :force => true do |t|
    t.string   "email"
    t.string   "direccion"
    t.string   "telefono"
    t.date     "fecha_alta"
    t.date     "fecha_baja"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "foto_entrega_file_name"
    t.string   "foto_entrega_content_type"
    t.integer  "foto_entrega_file_size"
    t.datetime "foto_entrega_updated_at"
  end

  add_index "direccions", ["user_id"], :name => "index_direccions_on_user_id"

  create_table "peticions", :force => true do |t|
    t.text     "mensaje"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "estado",        :default => "esperando"
    t.datetime "key_timestamp"
    t.string   "email"
  end

  add_index "peticions", ["estado"], :name => "index_peticions_on_estado"
  add_index "peticions", ["estado"], :name => "index_peticions_on_lifecycle_state"
  add_index "peticions", ["user_id"], :name => "index_peticions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.text     "descripcion"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "direccion_activa_id"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
    t.boolean  "disponible",                              :default => true
    t.date     "fecha_liberacion"
  end

  add_index "users", ["direccion_activa_id"], :name => "index_users_on_direccion_activa_id"
  add_index "users", ["state"], :name => "index_users_on_state"

end
