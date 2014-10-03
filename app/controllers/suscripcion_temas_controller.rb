class SuscripcionTemasController < ApplicationController
  def new
  	@suscripcion = SuscripcionTema.new
  end
  def create
      @suscripcion = SuscripcionTema.new
	    @suscripcion.usuario_id=current_user.id
	    @suscripcion.tema_id =params[:id]
	    @suscripcion.save
	    redirect_to :back
  end
  def delete
    @suscripcion = SuscripcionTema.where(usuario_id: current_user.id,tema_id: params[:id])
    if @suscripcion!=nil
      @suscripcion.destroy_all
    end
      redirect_to :back
    end
end