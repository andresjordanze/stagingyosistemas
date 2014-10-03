require 'pusher'
class MensajesController < ApplicationController
	skip_before_filter :verify_authenticity_token
  def enviar
  	para=Usuario.find_by_nombre_usuario(params[:para].to_s)
  	if (para)
	  	mensaje=Mensaje.create('de_usuario_id'=>current_user.id, 'para_usuario_id'=>para.id, 'mensaje' => params[:mensaje].to_s)
	  	if(mensaje)
	  		#flash[:alert]="Mensaje enviado!"
			Pusher.url = "http://5ea0579076700b536e21:503a6ba2bb803aa4ae5c@api.pusherapp.com/apps/60344"
			Pusher['chat_channel'].trigger('chat_event', {
			  mensaje: mensaje.mensaje,de_usuario: mensaje.de_usuario_id,para_usuario: mensaje.para_usuario_id , nombre_usuario: Usuario.find(mensaje.de_usuario_id).nombre_usuario
			})
	  	else
	  		flash[:alert]="Error al enviar el mensaje!"
	  	end
	else
		flash[:alert]="Error al enviar el mensaje usuario incorrecto!"
	end
  	redirect_to :back
  end
end