class CreateRespuesta < ActiveRecord::Migration
  def change
    create_table :respuesta do |t|
      t.references :pregunta, index: true
      t.string :texto
      t.string :respuesta_del_usuario

      t.timestamps
    end
  end
end
