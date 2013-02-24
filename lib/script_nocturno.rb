
# Encontrar las bicis que hay que liberar
bicis = User.find(:all, :conditions => ['disponible = ? AND fecha_liberacion <= ?', 'f', Date.today - 1.year])

# Por cada bicicleta, cambiarle el estado a "disponible"
for bici in bicis
  bici.update_attributes(:disponible => true, :fecha_liberacion => Date.today)

  # Por cada bicicleta, enviar un email diciendo X X 
  UserMailer.deliver_bicicleta_reliberada(bici) 
end
