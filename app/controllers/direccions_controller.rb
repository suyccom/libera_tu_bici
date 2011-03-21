class DireccionsController < ApplicationController

  hobo_model_controller

  auto_actions :write_only
  
  def create
    hobo_create do
      redirect_to @direccion.user
    end
  end

end
