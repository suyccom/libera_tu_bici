class BicicletasController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  
  def new
    @bicicleta = Bicicleta.new
    login_required
  end

end
