require 'spec_helper'

feature 'Gestion de SuscripcionTemas' do

	
	scenario 'suscribirse a un tema al crearlo' do
		grupo = FactoryGirl.create(:grupo)
    	usuario = FactoryGirl.create(:usuario)
    	tema = FactoryGirl.create(:tema)
    	suscribirse = FactoryGirl.create(:suscripcion_tema)
    	ingresar_sistema(usuario)
    	visit "temas/1"  #usar el id, titulo del tema con creado con factory girl
    	#save_and_open_page
    	#Capybara::Screenshot.screenshot_and_open_image
	    expect(page).to have_content 'Ya no me Interesa'
  	end

  	scenario 'quitar suscripcion a un tema' do
  		grupo = FactoryGirl.create(:grupo)
	    usuario = FactoryGirl.create(:usuario)
	    tema=FactoryGirl.create(:tema)
	    suscribirse = FactoryGirl.create(:suscripcion_tema)
    	ingresar_sistema(usuario)
    	visit "temas/1" 
	    expect(page).to have_content 'Ya no me Interesa'
	    click_link 'Ya no me Interesa'
	    expect(page).to have_content 'Me Interesa'
  	end
end
