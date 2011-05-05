

class PeticionObserver < ActiveRecord::Observer
  observe :peticion
 
  def after_update(peticion)
    #logger = RAILS_DEFAULT_LOGGER
    if peticion.estado_changed?
      if peticion.estado == 'completada'
        #FIXME: ¿Qué ocurre cuando una bicicleta se ha liberado con éxito?
        #¿Resetear contraseña? ¿Informar a los usuarios?
      elsif peticion.estado == 'denegada'
        UserMailer.deliver_peticion_denegada(peticion)
      end
    end
    
  end
  
end
