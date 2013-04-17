# Este pequeño script se utilizó el 8 abril 2013 para clonar todas las fotografías a la tabla correcta
for u in User.all; u.direccions.first.update_attribute(:foto_entrega, u.foto) if u.direccions.first; end
