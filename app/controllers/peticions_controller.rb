class PeticionsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index,:show]
  
  def create
    hobo_create do
      if valid?
        @mensaje_ok = "Mensaje enviado. Recibirás una respuesta en tu correo electrónico: <i>#{params[:peticion][:email]}</i>"
      else
        @mensaje_fallo = "Error. Por favor inténtalo de nuevo."
      end
      hobo_ajax_response if request.xhr?
    end
  end

end
