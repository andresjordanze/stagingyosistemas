require 'spec_helper'

feature 'Gestion de Grupo' do
  

  scenario 'Crear un nuevo grupo privado' do
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    click_link 'Crear Grupo'  #lleva al formulario para crear un grupo
    
    expect{
      fill_in 'grupo_nombre', with: 'Titulo tema de prueba'
      fill_in 'grupo_descripcion', with: 'Descripcion o contenido del tema de prueba'
      page.select("Privado", :from => "grupo_estado")
      click_button 'Crear grupo'
    }.to change(Grupo, :count).by(1)
    #expect(current_path).to eq grupos_path
    expect(current_path).to eq '/grupos/'+ Grupo.last.id.to_s #no muy util aqui, pero sirve para mostrar esta opcion
    
  end

#scenario 'Usuario con rol de estudiante no deberia crear temas' do
#    usuario = FactoryGirl.create(:other_student)
#    ingresar_sistema(usuario)
#    visit '/grupos/new'
#    expect(current_path).to eq root_path
 
        
# end



  scenario 'Crear un nuevo grupo publico' do
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    click_link 'Crear Grupo'  #lleva al formulario para crear un grupo
    
    expect{
      fill_in 'grupo_nombre', with: 'Titulo tema de prueba'
      fill_in 'grupo_descripcion', with: 'Descripcion o contenido del tema de prueba'
      page.select("Publico", :from => "grupo_estado")
      click_button 'Crear grupo'
    }.to change(Grupo, :count).by(1)
    expect(current_path).to eq root_path
    
  end

  scenario 'Suscribirse a un grupo privado' do
    docente = FactoryGirl.create(:usuario)
    estudiante = FactoryGirl.create(:other_user_estudiante)

    ingresar_sistema(docente)
    click_link 'Crear Grupo'  #lleva al formulario para crear un grupo
    
    expect{
      fill_in 'grupo_nombre', with: 'Titulo tema de prueba'
      fill_in 'grupo_descripcion', with: 'Descripcion o contenido del tema de prueba'
      page.select("Privado", :from => "grupo_estado")
      click_button 'Crear grupo'
    }.to change(Grupo, :count).by(1)
    expect(current_path).to eq '/grupos/'+ Grupo.last.id.to_s
    click_link 'Salir'
    ingresar_sistema(estudiante)
    #click_link 'Ver grupos'

  end

end
