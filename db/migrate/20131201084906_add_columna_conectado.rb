class AddColumnaConectado < ActiveRecord::Migration
  def change
  	add_column :usuarios, :conectado, :boolean, :default=>false
  end
end
