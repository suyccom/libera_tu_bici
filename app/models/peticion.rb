class Peticion < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    email :email_address, :required
    mensaje :text, :required
    timestamps
  end
  def name
    mensaje
  end

  #belongs_to :owner, :class_name => "User", :creator => true #El usuario que hace la petición
  belongs_to :user #La bicicleta que se ha pedido
  
  # --- Lifecycle --- #
  lifecycle :state_field => :estado do
    state :esperando, :default => :true
    state :denegada
    state :tramitando
    state :completada
  end
  def after_create
    UserMailer.deliver_peticion_bicicleta(self, user)
  end

  # --- Permissions --- #
  def create_permitted?
    return true unless user == acting_user
  end
  def update_permitted?
    acting_user.administrator?
  end
  def destroy_permitted?
    acting_user.administrator?
  end
  def view_permitted?(field)
    (user_is?(acting_user) || acting_user.administrator? || new_record?) && estado == "esperando"
  end
end
