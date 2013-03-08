class Direccion < ActiveRecord::Base

  #Nota: esta clase lleva un registro de todos los usuarios que han tenido la bicicleta. Fecha alta y fecha baja guardan la fecha en que el estado ha cambiado

  hobo_model # Don't put anything above this

  fields do
    email     :email_address, :required
    direccion :string, :name => true
    telefono :string
    fecha_alta :date
    fecha_baja :date
    timestamps
  end
  
  belongs_to :user
  
  has_one :bicicleta_en_uso, :class_name => "Bicicleta"
  
  has_attached_file :foto_entrega,
          :styles => {
            :original => ["1000x1000", :jpg ],
            :medium => ["500x800", :jpg ],
            :small => ["150x200", :jpg ],
            :thumbnail => ["100x100#", :jpg ]
          },
          :default_style => :small,
          :path => "#{RAILS_ROOT}/public/images/fotos_entregas/:style/:id_:basename.:extension",
          :url => "images/fotos_entregas/:style/:id_:basename.:extension"

  def after_create
    # Configuramos el usuario para que esta sea su dirección activa (la última en crearse)
    user.direccion_activa = self
    # Guardamos la fecha de liberación
    user.fecha_liberacion = Date.today
    # Cuando se crea una nueva dirección aparte de la original bloqueamos la bicicleta
    if user.direccions.count > 1
      user.disponible = false
    end
    user.save
    # Cuando se crea una nueva dirección actualizamos el estado de las peticiones en espera
    # Pueden pasar a estar completadas o denegadas
    for peticion in user.peticions
      if peticion.estado == "esperando"
        if peticion.email == email
          peticion.update_attribute(:estado, "completada")
        else
          peticion.update_attribute(:estado, "denegada")
        end
      end
    end
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
