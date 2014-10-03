class CreateSolicitudContrasenia < ActiveRecord::Migration
  def change
    create_table :solicitud_contrasenia do |t|
    	t.references :usuario, index: true
      t.timestamps
    end
  end
end
