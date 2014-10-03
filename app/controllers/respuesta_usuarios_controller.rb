class RespuestaUsuariosController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def nuevo
		@cuestionario = Cuestionario.find(params[:id])
	end
	def crear 
		@respuestas = params[:resp]
		@cuestionario_id = params[:id_cuestionario]
		@usuario_id = params[:id_usuario]
		@preguntas_id = params[:id_pregunta]
		@pregunta_tipo = params[:tipo_pregunta]
		cont = 0

		if(!RespuestaUsuario.ya_respondio_cuestionario(current_user.id,@cuestionario_id))
			@respuestas.each { |key,respuesta_usuario|  
				respuesta_usuario.each { |valor|
					@respuestaUsuario = RespuestaUsuario.new(:respuesta => valor, :cuestionario_id => @cuestionario_id , 
						:usuario_id => @usuario_id, :pregunta_id => key.to_s, :tipo => @pregunta_tipo[key].to_s)

					res = Respuesta.where(pregunta_id: key)
					res.each do |reee|
						if key.to_s==reee.pregunta_id.to_s && valor==reee.texto && reee.respuesta_correcta == true
							@respuestaUsuario.calificacion = true
							break
						else
							@respuestaUsuario.calificacion = false
						end
					end	
					@respuestaUsuario.save
					#agregar_archivos_adjuntos(@respuestaUsuario.id, key)	
				}
			}
		end


		
	end
=begin
	def crear
		@contador = params[:cont]
		@cuestionario_id = params[:id_cuestionario]
		current_user.respuesta_usuarios.create(respuesta: params[:respuetabool])
		redirect_to "/cuestionarios/nuevo/"+@cuestionario_id.to_s
	end
	def terminado
		current_user.respuesta_usuarios.create(respuesta: params[:respuetabool])
		redirect_to root_path
	end
=end

private
    def agregar_archivos_adjuntos(respuesta_usuario_id, idPregunta)
      if(!params[:archivo][idPregunta].nil?)
        @archivo = AdjuntoRespuestaCuestionario.new(:archivo=>params[:archivo][idPregunta])
        @archivo.respuesta_usuario_id = respuesta_usuario_id
        @archivo.save
       
      end
    end

    def eliminar_archivos_adjuntos(idsParaBorrar)
        if (!idsParaBorrar.nil?)
          idsParaBorrar.slice!(0)
           idsParaBorrar=idsParaBorrar.split("-")
           idsParaBorrar.each do |id|
               AdjuntoRespuestaCuestionario.destroy(id)
           end
        end
    end

end
