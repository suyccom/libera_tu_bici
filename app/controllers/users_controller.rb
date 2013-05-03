class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [ :new, :create ]

  def show
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
    if params[:email].blank?
    else
      usuario = User.find_by_name(params[:bicicleta])
      if usuario && usuario.direccions.last && usuario.direccions.last.email == params[:email]
        if usuario.administrator
          @admin_login = true
          if params[:password] && User.authenticate(usuario.name, params[:password])
            self.current_user = usuario
            flash[:error] = ""
            flash[:notice] = "Bienvenido!"
            redirect_to current_user
          else
            flash[:error] = "Los administradores tienen que introducir email y contraseña."
          end
        else
          self.current_user = usuario
          flash[:error] = ""
          flash[:notice] = "Bienvenido!"
          redirect_to current_user
        end
      else
        flash[:error] = "No existe ningún usuario con esa dirección activa."
      end
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

  def recuperar
    if params[:email] && params[:bicicleta]
      direccion = Direccion.find_by_email(params[:email])
      bicicleta = params[:bicicleta]
      usuario = direccion.user if direccion
      if direccion && usuario && bicicleta && direccion == usuario.direccions.first && bicicleta == usuario.name
        UserMailer.deliver_recuperar_bicicleta_prestamo(usuario) # Email a la direccion actual
        UserMailer.deliver_recuperar_bicicleta(usuario) # Email al dueño
        usuario.update_attributes(:devuelta => true, :disponible => false)
        flash[:notice] = 'El proceso de recuperación de bicicleta ha comenzado, por favor compruebe su correo electrónico.'
      else
        flash[:error] = 'No hemos encontrado ninguna bicicleta con este email'
      end
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
  
  def update
    hobo_update do
      if params[:direccion]
        this.update_attribute(:direccion, params[:direccion])
      end
    end
  end
end
