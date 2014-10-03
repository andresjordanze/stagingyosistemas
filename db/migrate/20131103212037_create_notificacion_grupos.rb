class CreateNotificacionGrupos < ActiveRecord::Migration
  def change
    create_table :notificacion_grupos do |t|
      t.boolean :notificado
      t.references :subscripcion, index: true
      t.references :tarea, index: true

      t.timestamps
    end
  end
end
