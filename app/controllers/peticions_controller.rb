class PeticionsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index,:show]
  
  def create
    @mensaje = "Mensaje enviado. Recibirás una respuesta en tu correo electrónico: <i>#{params[:peticion][:email]}</i>"
    hobo_create do
      hobo_ajax_response if request.xhr?
    end
  end



end







# --- Deprecated code --- #


  ###########################
  #--- Lifecycle Actions ---#
  ###########################
#  def do_bicicleta_entregada_a_este_usuario
#    #flash[:notice] = "La orden de trabajo ha sido marcada como entregada"
#    @peticion = Peticion.find(params[:id])
#    @peticion.bicicleta.estado = "no_disponible"
#    @peticion.bicicleta.save
#    do_transition_action :bicicleta_entregada_a_este_usuario
#  end
