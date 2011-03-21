class Direccion < ActiveRecord::Base

  #Nota: esta clase lleva un registro de todos los usuarios que han tenido la bicicleta. Fecha alta y fecha baja guardan la fecha en que el estado ha cambiado

  hobo_model # Don't put anything above this

  fields do
    email     :email_address
    direccion :string, :name => true
    telefono :string
    fecha_alta :date
    fecha_baja :date
    timestamps
  end
  
  belongs_to :user
  
  has_one :bicicleta_en_uso, :class_name => "Bicicleta"
  
  def after_create
    user.update_attribute(:direccion_activa, self)
  end


  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
