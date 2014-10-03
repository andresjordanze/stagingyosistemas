class AddReferenciaTareaBase < ActiveRecord::Migration
  def change
  	add_column :tareas, :tarea_base, :int, :default=>nil
  end
end
