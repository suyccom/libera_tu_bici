class UserMailer < ActionMailer::Base
  
  def forgot_password(user, key)
    host = Hobo::Controller.request_host
    app_name = Hobo::Controller.app_name || host
    @subject    = "#{app_name} -- contraseña olvidada"
    @body       = { :user => user, :key => key, :host => host, :app_name => app_name }
    if Rails.env.production?
      @recipients = user.email_address 
    else
      @recipients = 'tecnicos@unoycero.com'
    end
    @from       = 'notificaciones@liberatubici.org'
    @sent_on    = Time.now
    @headers    = {}
  end
  
  
  def peticion_bicicleta(peticion, user)
    subject 'Nueva petición de bicicleta'
    if Rails.env.production?
      recipients user.direccion_activa.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    from 'notificaciones@liberatubici.org'
    @peticion = peticion
    @user = user
  end
  
  
  def peticion_denegada(peticion)
    subject 'Petición de bicicleta denegada'
    if Rails.env.production?
      recipients peticion.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    @peticion = peticion
  end
  
  def bicicleta_entregada(peticion)
    subject 'Enhorabuena por tu nueva bicicleta'
    if Rails.env.production?
      recipients peticion.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    @peticion = peticion
  end

  def bicicleta_reliberada(usuario)
    subject 'Libera tu bici: Ha pasado un año desde que adquiriste tu bicicleta'
    if Rails.env.production?
      recipients usuario
    else
      recipients 'tecnicos@unoycero.com'
    end
    
  end
  
end
