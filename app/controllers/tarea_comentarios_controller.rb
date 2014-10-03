class TareaComentariosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    @tarea = Tarea.find(params[:tarea_id])
    @comentario = @tarea.tarea_comentarios.create(comentario_params)
    @comentario.usuario_id = current_user.id
    @comentario.save
    add_attached_files(@comentario.id)
    redirect_to @tarea
  end

  private
    def add_attached_files(tarea_comentario_id)
      if(!params[:tarea_comentario][:archivo].nil?)
        params[:tarea_comentario][:archivo].each do |arch|
        @archivo = AdjuntoTareaComentario.new(:archivo=>arch)
        @archivo.tarea_comentario_id = tarea_comentario_id
        @archivo.save
        end
      end
    end

    def eliminar_archivos_adjuntos(idsParaBorrar)
        if (!idsParaBorrar.nil?)
          idsParaBorrar.slice!(0)
           idsParaBorrar=idsParaBorrar.split("-")
           idsParaBorrar.each do |id|
               AdjuntoTareaComentario.destroy(id)
           end
        end
    end

    public

  def editar
        comentario = TareaComentario.find(params[:id])
        comentario.update(params[:tarea_comentario].permit(:cuerpo))
        eliminar_archivos_adjuntos(params[:elemsParaElim])
        add_attached_files(comentario.id)
        comentario.save
        redirect_to comentario.tarea
   end
   def delete
        @comentario = TareaComentario.find(params[:id])
        if(@comentario.usuario.correo == current_user.correo)
            @comentario.destroy
        end
        redirect_to @comentario.tarea
    end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comentario_params
      params.require(:tarea_comentario).permit(:cuerpo)
    end
end
