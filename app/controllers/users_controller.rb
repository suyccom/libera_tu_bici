class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [ :new, :create ]
  
  def show
    @peticion = Peticion.new
    @nueva_direccion = Direccion.new
    hobo_show
  end
  
  
  def do_signup
    hobo_do_signup do
      self.current_user = this if this.account_active?
      redirect_to @user if valid?
    end
  end 
  
  
  
  def index
    @estado_actual = params[:estado]
  
    hobo_index User.apply_scopes(
      :not_administrator => true,
      :con_direccion_activa => true)
  end

end
