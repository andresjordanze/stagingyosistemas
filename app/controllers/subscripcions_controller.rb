class SubscripcionsController < ApplicationController

	skip_before_filter :verify_authenticity_token

    def create
    	@grupo = Grupo.find(params[:grupo_id])
    	@subscripcion = @grupo.subscripcions.create(subscripcions_params)

      if @subscripcion.verificar_llave(@grupo.llave)
    	   @subscripcion.usuario_id = current_user.id
    	   @subscripcion.save
         SendMail.notify_users_grupo(current_user, @grupo.nombre).deliver #con sto envio el correo
    	   redirect_to grupos_path, :flash => { :info => "Suscrito exitosamente" }
      else
         @subscripcion.destroy
         redirect_to suscribirse_path(@grupo), :flash => { :error => "Error al ingresar la llave" }
      end
  	end

    def delete
        @suscripcion = Subscripcion.find(params[:id])
        @grupo = @suscripcion.grupo
        @suscripcion.destroy
        redirect_to suscriptores_path(@grupo)
    end

    def notificar
      @usuario = Usuario.find(params[:usuario_id])
      SendMail.notify_user(current_user, @usuario)
      redirect_to grupos_path, notice: 'Se actualizo el estado.'
    end
private
	def subscripcions_params
		params.require(:subscripcion).permit(:llave)
	end
end
