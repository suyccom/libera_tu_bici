class Bicicleta < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string, :required
    lugar :string, :required
    descripcion :text
    timestamps
  end
  
  

  
  


  #belongs_to :user
#  belongs_to :owner, :class_name => "User", :creator => true
#  has_many :peticions
#  has_many :peticionarios, :through => :peticions, :source => :owner
  

  
  
  # --- Lifecycle --- #
  
  lifecycle :state_field => :estado do
  
    state :disponible, :default => :true
    state :no_disponible
#    transition :test, { :disponible => :no_disponible }, :available_to => :all

  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    #acting_user.administrator?
    acting_user.administrator? || owner_is?(acting_user)
  end

  def destroy_permitted?
    acting_user.administrator? || owner_is?(acting_user)
  end

  def view_permitted?(field)
    true
  end

end
