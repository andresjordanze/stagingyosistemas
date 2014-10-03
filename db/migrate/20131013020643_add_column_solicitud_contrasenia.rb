class AddColumnSolicitudContrasenia < ActiveRecord::Migration
  def change
  	add_column :usuarios, :solicitud_contrasenia_id, :integer
  end
end