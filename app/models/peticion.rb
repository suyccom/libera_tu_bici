class Peticion < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    email :email_address, :required
    mensaje :text, :required
    timestamps
  end
  
  
  #belongs_to :owner, :class_name => "User", :creator => true #El usuario que hace la petición
  belongs_to :user #La bicicleta que se ha pedido
  
  
  
  # --- Lifecycle --- #
  
  lifecycle :state_field => :lifecycle_state do
  
    state :esperando, :default => :true
    state :denegada
    state :tramitando
    state :completada
    
#    transition :denegar_donacion, { :esperando => :denegada }, :available_to => "bicicleta.owner"
#    transition :bicicleta_entregada_a_este_usuario, { :esperando => :completada }, :available_to => "bicicleta.owner"


  end


  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    user_is?(acting_user) || acting_user.administrator? || new_record?
  end

end
