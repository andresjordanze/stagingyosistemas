class AddNombreUsuarioToUsuario < ActiveRecord::Migration
  def change
  	add_column :usuarios, :nombre_usuario , :string
  end
end
