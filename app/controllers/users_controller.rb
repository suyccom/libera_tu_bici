class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [ :new, :create ]
  
  def show
    @peticion = Peticion.new
    hobo_show
  end

end
