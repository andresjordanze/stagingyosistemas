class AddHoraEntregaToTareas < ActiveRecord::Migration
  def change
    add_column :tareas, :hora_entrega, :time, :format => :short
  end
end
