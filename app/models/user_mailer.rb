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
    from 'notificaciones@liberatubici.org'
    @peticion = peticion
  end
  
  def bicicleta_entregada(peticion)
    subject "Enhorabuena por la bicicleta #{peticion.user}"
    if Rails.env.production?
      recipients peticion.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    from 'notificaciones@liberatubici.org'
    @peticion = peticion
  end

  def notificacion_todos(peticion,destinatarios)
    subject "La bici #{peticion.user} ha cambiado de casa"
    if Rails.env.production?
      bcc destinatarios
    else
      recipients 'tecnicos@unoycero.com'
    end
    content_type "text/html"
    from 'notificaciones@liberatubici.org'
    @peticion = peticion
    if peticion.user.direccion_activa.foto_entrega.to_file
      attachment :content_type => 'image/jpeg',
                 :body => peticion.user.direccion_activa.foto_entrega.to_file(:medium).read,
                 :filename => 'foto_entrega.jpg'
    end
  end

  def bicicleta_reliberada(bici)
    subject 'Libera tu bici: Ha pasado un año desde que adquiriste tu bicicleta'
    if Rails.env.production?
      recipients bici.direccion_activa.email
      bcc ['tecnicos@unoycero.com']
    else
      recipients 'tecnicos@unoycero.com'
    end
    from 'notificaciones@liberatubici.org'
    @bicicleta = bici
  end

  def recuperar_bicicleta_prestamo(usuario)
    subject "El dueño original quiere recuperar su bicicleta #{usuario.name}"
    if Rails.env.production?
      recipients usuario.direccion_activa.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    from 'notificaciones@liberatubici.org'
    @usuario = usuario
  end

  def recuperar_bicicleta(usuario)
    subject "Tu bicicleta #{usuario.name} ha comenzado el proceso de recuperación"
    if Rails.env.production?
      recipients usuario.direccions.first.email
    else
      recipients 'tecnicos@unoycero.com'
    end
    from 'notificaciones@liberatubici.org'
    @usuario = usuario
  end
  
end
