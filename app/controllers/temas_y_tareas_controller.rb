class TemasYTareasController < ApplicationController
  skip_before_filter :require_log_in,:only=>[:index]
  def index
    
    if( params[:id] != nil && Grupo.find(params[:id]).habilitado)
       @grupo = Grupo.find(params[:id])
    else
       @grupo = Grupo.find(1)
       redirect_to temas_path
    end
    if(params[:id]=="1")
      redirect_to temas_path
    else
      @temas = @grupo.temas.order("updated_at DESC").page(params[:page]).per(3)
      @tareas = Tarea.where(:grupo_id => params[:id]).order("updated_at DESC").page(params[:page]).per(3)
    end
  end

end
