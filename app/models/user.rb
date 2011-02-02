class User < ActiveRecord::Base

  # Nota: en esta aplicación las usuarias son las bicicletas, no las personas :)
  
  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique, :login => true
    email_address     :email_address
    descripcion   :text
    administrator :boolean, :default => false
    timestamps
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
          
          
  validates_attachment_presence :foto
  validates_attachment_size :foto, :less_than => 2.megabytes
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png']
    
  

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
  before_create { |user| user.administrator = true if !Rails.env.test? && count == 0 }

  
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
    acting_user.administrator? || 
      (acting_user == self && only_changed?(:email_address, :crypted_password,
                                            :current_password, :password, :password_confirmation))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
