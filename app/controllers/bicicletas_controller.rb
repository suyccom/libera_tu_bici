class BicicletasController < ApplicationController

  hobo_model_controller

  auto_actions :write_only
  
  
  def new
    @bicicleta = Bicicleta.new
    login_required
  end



  ########################
  #---- Search Scopes ---#
  ########################
  def index
    #Por defecto solo muestra las disponibles
    if (!params[:estado])
      params[:estado] = 'disponible'
    end
  
  
    @estado_actual = params[:estado]
    hobo_index Bicicleta.apply_scopes(
      :estado_is => params[:estado])
  end


end
