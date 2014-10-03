class CreateArchivoAdjuntos < ActiveRecord::Migration
  def change
    create_table :archivo_adjuntos do |t|
      t.references :tarea, index: true
      t.timestamps
    end
    add_attachment :archivo_adjuntos, :archivo
  end
end