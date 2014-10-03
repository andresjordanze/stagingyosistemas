require 'spec_helper'

feature 'Gestion de Evento' do
	scenario 'Crear un evento' do
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    visit '/eventos/new'  #lleva al formulario para crear un grupo
    
    expect{
      fill_in 'evento_nombre', with: 'Titulo evento de prueba'
      fill_in 'evento_detalle', with: 'Descripcion o contenido del evento de prueba'
      click_button 'Guardar evento'
    }.to change(Evento, :count).by(1)
   	expect(current_path).to eq '/eventos/'+ Evento.last.id.to_s #no muy util aqui, pero sirve para mostrar esta opcion
    
  end
  scenario 'Eliminar un evento' do
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    visit '/eventos/new'  #lleva al formulario para crear un grupo
    
    expect{
      fill_in 'evento_nombre', with: 'Titulo evento de prueba'
      fill_in 'evento_detalle', with: 'Descripcion o contenido del evento de prueba'
      click_button 'Guardar evento'
    }.to change(Evento, :count).by(1)
   	expect(current_path).to eq '/eventos/'+ Evento.last.id.to_s #no muy util aqui, pero sirve para mostrar esta opcion
    click_link 'Eliminar Evento'
    expect(page).to have_content 'Evento eliminado'
  end
end