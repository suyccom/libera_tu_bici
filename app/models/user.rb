class User < ActiveRecord::Base

  # Nota: en esta aplicación las usuarias son las bicicletas, no las personas :)
  hobo_user_model

  fields do
    name              :string, :required, :unique, :login => true
    descripcion       :text
    administrator     :boolean, :default => false
    disponible        :boolean, :default => true
    fecha_liberacion  :date
    devuelta          :boolean, :default => false
    timestamps
  end

  has_many :direccions
  has_many :peticions
  belongs_to :direccion_activa, :class_name => "Direccion"

  set_default_order "fecha_liberacion asc"

  has_attached_file :foto,
          :styles => {
            :original => ["1000x1000", :jpg ],
            :medium => ["500x800", :jpg ],
            :small => ["150x200", :jpg ],
            :thumbnail => ["100x100#", :jpg ]
          },
          :default_style => :small,
          :path => "#{RAILS_ROOT}/public/images/fotos/:style/:id_:basename.:extension",
          :url => "images/fotos/:style/:id_:basename.:extension"

  # Campo adicional para la edición de la dirección
  def direccion
    direccion_activa && direccion_activa.direccion ? direccion_activa.direccion : ''
  end
  def direccion=(direccion)
    direccion_activa.update_attribute(:direccion, direccion) if direccion_activa
  end

  # Campo adicional para editar el email
  def email_address
    direccion_activa ? direccion_activa.email : ''
  end
  def email_address=(direccion_email)
    direccion_activa.update_attribute(:email, direccion_email) if direccion_activa
  end

  # Campo adicional para editar la foto
  def foto_entrega
    direccion_activa ? direccion_activa.foto_entrega : ''
  end
  def foto_entrega=(foto_entrega)
    direccion_activa.update_attribute(:foto_entrega, foto_entrega) if direccion_activa
  end

  # Calculamos la fecha en la que la bici volverá a ser liberada
  def fecha_proxima_liberacion
    if devuelta
      return "No disponible"
    elsif fecha_liberacion
      return fecha_liberacion.to_time.next_year.to_date
    else
      return "Error"
    end
  end

  # Names Scopes
  # Buscar solo los que tengan direccion activa
  named_scope :con_direccion_activa, :conditions => "users.direccion_activa_id IS NOT NULL"

  # Signup lifecycle
  lifecycle do
    state :active, :default => true
    create :signup, :available_to => "Guest",
           :params => [:name, :email_address, :descripcion, :foto, :direccion_activa_id, :fecha_liberacion],
           :become => :active
  end

  # Permissions
  def create_permitted?
    false
  end
  def update_permitted?
    return true if acting_user.administrator?
    return true if acting_user == self && none_changed?(:name)
    return true if acting_user == self && direccions.size == 1
  # Note: crypted_password has attr_protected so although it is permitted to 
  # change, it cannot be changed directly from a form submission.
  end
  def destroy_permitted?
    acting_user.administrator? || (acting_user == self && self.direccions.size == 1)
  end
  def view_permitted?(field)
    acting_user == self || self.direccion_activa || acting_user.administrator? || new_record?
  end
end
