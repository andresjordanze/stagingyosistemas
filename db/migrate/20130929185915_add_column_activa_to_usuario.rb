class AddColumnActivaToUsuario < ActiveRecord::Migration
  def change
  	add_column :usuarios, :activa, :boolean, :default=>false
  end
end
