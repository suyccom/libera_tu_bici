# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  

private
 
  def log_error(exception)
    # Logging por defecto al fichero de log
    ActiveSupport::Deprecation.silence do
      if ActionView::TemplateError === exception
        logger.fatal(exception.to_s)
      else
        logger.fatal(
          "\n#{exception.class} (#{exception.message}):\n  " +
          clean_backtrace(exception).join("\n  ") + "\n\n"
        )
      end
    end  
 
    # Envío de error por mensajería Jabber
    if Rails.env.production?
      # Preparar mensaje
      Socket.do_not_reverse_lookup = false
      mensaje = "Ha ocurrido un error en #{RAILS_ROOT.split('/').last}: \n" +
       Time.now.to_s +
       "\nURL: http://#{request.env['HTTP_HOST'] }#{request.env['REQUEST_URI'] }" +
 
      "\n\nIP: #{request.env['REMOTE_ADDR']}" + 
      "\nHost: #{Socket.getaddrinfo(request.env['REMOTE_ADDR'],nil)[0][2]}" + 
      "\nNavegador: #{request.env['HTTP_USER_AGENT'] }" +
 
       "\n\nError: #{exception.class} (#{exception.message}):\n  " +
       clean_backtrace(exception).join("\n  ").to_s.first(600)
 
      # Limpiar acentos para poder enviarlos por Jabber
      mensaje = mensaje.gsub(/[^0-9A-Za-z:\n\-\.\_\n\/\s]/, '')
 
      # logger.info('A continuacion el mensaje que se va a enviar por Jabber')
      # logger.info(mensaje)
 
      comando = "echo '" + mensaje + "' | /usr/local/scripts/jabbersend.rb -t suyccom.alertas@chat.sinanimodelucro.net 1>/dev/null"
      system(comando)
    end
  end  
  
  
end
