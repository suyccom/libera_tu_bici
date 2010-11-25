class Peticion < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    mensaje :text
    timestamps
  end
  
  belongs_to :owner, :class_name => "User", :creator => true #El usuario que hace la petición
  belongs_to :bicicleta #La bicicleta que pide
  
  
  
  # --- Lifecycle --- #
  
  lifecycle :state_field => :lifecycle_state do
  
    state :esperando, :default => :true
    state :denegada
    state :tramitando
    state :completada
    
    transition :denegar_donacion, { :esperando => :denegada }, :available_to => "bicicleta.owner"
    transition :bicicleta_entregada_a_este_usuario, { :esperando => :completada }, :available_to => "bicicleta.owner"


  end


  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? && acting_user != bicicleta.owner && bicicleta.estado == "disponible" && !bicicleta.peticionarios.member?(acting_user)
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    #true
    owner_is?(acting_user) || bicicleta.owner == acting_user || acting_user.administrator?
  end

end
