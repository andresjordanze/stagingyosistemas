class CreateRespuestaUsuarios < ActiveRecord::Migration
  def change
    create_table :respuesta_usuarios do |t|
      t.string :respuesta
      t.string :tipo
      t.references :cuestionario, index: true
      t.references :usuario, index: true
      t.references :pregunta, index: true

      t.timestamps
    end
  end
end
