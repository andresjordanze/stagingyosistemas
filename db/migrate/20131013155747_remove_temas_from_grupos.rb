class RemoveTemasFromGrupos < ActiveRecord::Migration
  def change
    remove_reference :grupos, :tema, index: true
  end
end
