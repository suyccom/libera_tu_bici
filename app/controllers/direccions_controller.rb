class DireccionsController < ApplicationController

  hobo_model_controller

  auto_actions :write_only
  
  def create
    hobo_create do
      if @direccion.user.direccions.count > 1
        reset_session
        flash[:notice] = "La bicicleta ha sido traspasada al nuevo dueño con éxito. ¡Gracias!"
      else
        flash[:notice] = "La bicicleta ha sido liberada con éxito. ¡Gracias!"
      end
      redirect_to @direccion.user
    end
  end

end
