class User < ActiveRecord::Base

  # Nota: en esta aplicación las usuarias son las bicicletas, no las personas :)
  
  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique, :login => true
    email_address     :email_address
    descripcion   :text
    administrator :boolean, :default => false
    disponible :boolean, :default => true
    fecha_liberacion :date
    timestamps
  end
  
  
  # --- Campos adicionales para el formulario de signup --- #
  attr_accessor :telefono, :type => :string
  
  
  # --- Campo adicional para la edición de la dirección --- #
  def direccion
    if direccion_activa
      direccion_activa.direccion 
    else
      ''
    end
  end
  def direccion=(direccion)
    if direccion_activa
      direccion_activa.update_attribute(:direccion, direccion)
    end
  end
  
  # --- Calculamos la fecha en la que la bici volverá a ser liberada --- #
  def fecha_proxima_liberacion
    if fecha_liberacion
      fecha_liberacion.to_time.next_year.to_date
    else
      "Error"
    end
  end
  
  
  
  
  has_many :direccions
  has_many :peticions
  belongs_to :direccion_activa, :class_name => "Direccion"
  
  
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
  #validates_attachment_presence :foto
  #validates_attachment_size :foto, :less_than => 2.megabytes
  #validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png']
    
  

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
#  before_create { |user| user.administrator = true if !Rails.env.test? && count == 0 }



  set_default_order "fecha_liberacion asc"
  


# --- Names Scopes --- #
  # Buscar solo los que tengan direccion activa
  named_scope :con_direccion_activa, :conditions => "users.direccion_activa_id IS NOT NULL"





  
  # --- Signup lifecycle --- #

  lifecycle do

    state :active, :default => true

    create :signup, :available_to => "Guest",
           :params => [:name, :email_address, :password, :password_confirmation],
           :become => :active
             
    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.deliver_forgot_password(self, lifecycle.key)
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end
  
  

  

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    #acting_user.administrator? || 
    #(acting_user == self && only_changed?(:email_address, :crypted_password,
    #       :current_password, :password, :password_confirmation))
    acting_user.administrator? || (acting_user == self)
    
    
    
    
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator? || (acting_user == self && self.direccions.size == 1)
  end

  def view_permitted?(field)
    acting_user == self || self.direccion_activa || acting_user.administrator? || new_record?
  end

end
