class AgregarColumnaARespuestas < ActiveRecord::Migration
  def self.up
    add_column :respuestas, :respuesta_correcta, :boolean
  end

 def self.down
    remove_column :respuestas, :respuesta_correcta
 end
end
