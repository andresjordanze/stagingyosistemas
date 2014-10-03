class AddGrupoRefToUsuarios < ActiveRecord::Migration
  def change
    add_reference :usuarios, :grupo, index: true
  end
end
