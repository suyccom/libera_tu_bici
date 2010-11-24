class PeticionsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index,:show]
  
  auto_actions_for :bicicleta, [:create]

end
