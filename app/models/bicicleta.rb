class Bicicleta < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string
    lugar :string
    descripcion :text
    timestamps
  end
  
  
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
  

  #belongs_to :user
  belongs_to :owner, :class_name => "User", :creator => true
  has_many :peticions

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    #acting_user.administrator?
    acting_user.administrator? || owner_is?(acting_user)
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
