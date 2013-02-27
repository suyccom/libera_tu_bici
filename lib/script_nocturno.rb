
# Encontrar las bicis que hay que liberar
bicis = User.find(:all, :conditions => ['disponible = ? AND fecha_liberacion <= ?', 'f', Date.today - 1.year])

# Por cada bicicleta, cambiarle el estado a "disponible"
for bici in bicis
  unless bici.devuelta
    bici.update_attributes(:disponible => true, :fecha_liberacion => Date.today)

    # Por cada bicicleta, enviar un email diciendo X X 
    usuario = bici.direccion_activa.email
    UserMailer.deliver_bicicleta_reliberada(usuario)
  end 
end
