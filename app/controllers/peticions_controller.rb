class PeticionsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index,:show]
  
  auto_actions_for :bicicleta, [:create]
  
  
  
  ###########################
  #--- Lifecycle Actions ---#
  ###########################
  def do_bicicleta_entregada_a_este_usuario
    #flash[:notice] = "La orden de trabajo ha sido marcada como entregada"
    @peticion = Peticion.find(params[:id])
    @peticion.bicicleta.estado = "no_disponible"
    @peticion.bicicleta.save
    do_transition_action :bicicleta_entregada_a_este_usuario
  end

end
