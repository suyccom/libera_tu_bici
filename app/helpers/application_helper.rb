# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def apano_fecha(fecha)
    if fecha.to_s(:long).include? "January"
      return fecha.to_s(:long).gsub("January", "enero")
    end
    if fecha.to_s(:long).include? "February"
      return fecha.to_s(:long).gsub("February", "febrero")
    end
    if fecha.to_s(:long).include? "March"
      return fecha.to_s(:long).gsub("March", "marzo")
    end
    if fecha.to_s(:long).include? "April"
      return fecha.to_s(:long).gsub("April", "abril")
    end
    if fecha.to_s(:long).include? "May"
      return fecha.to_s(:long).gsub("May", "mayo")
    end
    if fecha.to_s(:long).include? "June"
      return fecha.to_s(:long).gsub("June", "junio")
    end
    if fecha.to_s(:long).include? "July"
      return fecha.to_s(:long).gsub("July", "julio")
    end
    if fecha.to_s(:long).include? "August"
      return fecha.to_s(:long).gsub("August", "agosto")
    end
    if fecha.to_s(:long).include? "September"
      return fecha.to_s(:long).gsub("September", "setiembre")
    end
    if fecha.to_s(:long).include? "October"
      return fecha.to_s(:long).gsub("October", "octubre")
    end
    if fecha.to_s(:long).include? "November"
      return fecha.to_s(:long).gsub("November", "noviembre")
    end
    if fecha.to_s(:long).include? "December"
      return fecha.to_s(:long).gsub("December", "diciembre")
    end
  end
  
end
