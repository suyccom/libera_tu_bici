class DireccionHints < Hobo::ViewHints

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
  
  field_help :direccion => "La dirección solo se utiliza para el mapa. No hace falta ponerla completa :)",
    :email => "El email no se lo mostramos a los demás usuarios, solo lo usamos para contactar contigo cuando alguien se interesa por la bicicleta."
end
