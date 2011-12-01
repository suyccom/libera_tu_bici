class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [ :new, :create ]
  
  def show
    if params[:masinfo]
      @test = "patata - nos han pasado el ID " + params[:masinfo]
    end
    @peticion = Peticion.new
    @nueva_direccion = Direccion.new
    hobo_show do
      hobo_ajax_response if request.xhr?
    end
  end
  
  
  def do_signup
    hobo_do_signup do
      self.current_user = this if this.account_active?
      redirect_to @user if valid?
    end
  end 
  
  
  def login
    hobo_login do
      redirect_to current_user
    end
  end
  
  # Si un usuario ya está logueado y pulsa en liberar bicicleta, cerrar su sesión automáticamente
  def signup
    unless current_user.class == Guest
      hobo_logout do
        redirect_to '/users/signup'
      end
    else
      hobo_signup
    end
  end
  
  
  
  def index
    @estado_actual = params[:estado]
    
    @bicis_no_disponibles = User.not_disponible
  
    hobo_index User.apply_scopes(
      :disponible => true,
      :not_administrator => true,
      :con_direccion_activa => true)
  end
  
  
  
  
  
  
  
  
  
  
  # Personalizar controlador forgot_password: en esta aplicación el email se guarda en otra tabla
  def forgot_password
    if request.post?
      # Simplemente cambiamos la forma de encontrar el usuario
      # user = model.find_by_email_address(params[:email_address])
      if Direccion.find_by_email(params[:email_address])
        user = Direccion.find_by_email(params[:email_address]).user
      end
      if user && (!block_given? || yield(user))
        user.lifecycle.request_password_reset!(:nobody)
      end
      respond_to do |wants|
        wants.html { render_tag :forgot_password_email_sent_page }
        wants.js { hobo_ajax_response}
      end
    end
  end
  
  
  
  
  
  
  
  
end
