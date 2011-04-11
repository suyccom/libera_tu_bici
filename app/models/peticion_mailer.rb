class PeticionMailer < ActionMailer::Base
  

  def peticion_bicicleta(sent_at = Time.now)
    subject    'PeticionMailer#peticion_bicicleta'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
