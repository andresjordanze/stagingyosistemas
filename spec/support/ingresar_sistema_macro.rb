module IngresarSistemaMacro
	def ingresar_sistema(usuario)
	    visit root_path
	    #click_link "Ingresar"  
	    fill_in 'correo', with: 'email@email.com'
	    fill_in 'contrasenia', with: 'password'
	    click_button 'Ingresar'
	end
end

