class RenombrarTablasPreguntaYRespuesta < ActiveRecord::Migration
  def self.up
    rename_table :pregunta, :preguntas
    rename_table :respuesta, :respuestas
  end

 def self.down
    rename_table :preguntas, :pregunta
    rename_table :respuestas, :respuesta
 end
end
