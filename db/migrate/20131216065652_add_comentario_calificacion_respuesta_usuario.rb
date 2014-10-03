class AddComentarioCalificacionRespuestaUsuario < ActiveRecord::Migration
  def change
  	add_column :respuesta_usuarios, :calificacion, :boolean
  	add_column :respuesta_usuarios, :comentario, :string
  end
end
