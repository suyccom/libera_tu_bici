class UserMailer < ActionMailer::Base
  
  def forgot_password(user, key)
    host = Hobo::Controller.request_host
    app_name = Hobo::Controller.app_name || host
    @subject    = "#{app_name} -- forgotten password"
    @body       = { :user => user, :key => key, :host => host, :app_name => app_name }
    @recipients = user.email_address
    @from       = "no-reply@#{host}"
    @sent_on    = Time.now
    @headers    = {}
  end
  
  
  def peticion_bicicleta(peticion, user)
    subject 'Nueva petición de bicicleta'
    recipients user.direccion_activa.email
    from 'bicicleta_liberada@bizizbizi.org'
    @peticion = peticion
    @user = user
  end
  
  
  def peticion_denegada(peticion)
    subject 'Petición de bicicleta denegada'
    recipients peticion.email
    @peticion = peticion
  end
  
end
