class AddGrupoRefToTemas < ActiveRecord::Migration
  def change
    add_reference :temas, :grupo, index: true
  end
end
