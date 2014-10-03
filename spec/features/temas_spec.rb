require 'spec_helper'

feature 'Gestion de tema' do
  #TODO: Llevar este método a un spec_helper para que sea usado por todos los feature specs
  #TODO: Usar el parametro usuario en este método
 

  scenario 'Crear un nuevo tema' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    ingresar_sistema(usuario)
    click_link 'Nuevo Tema'
    
    expect{
      fill_in 'tema_titulo', with: 'Titulo tema de prueba'
      fill_in 'tema_cuerpo', with: 'Descripcion o contenido del tema de prueba'
      click_button 'Crear tema'
    }.to change(Tema, :count).by(1)
    expect(current_path).to eq "/grupos/1/temas"  #no muy util aqui, pero sirve para mostrar esta opcion
    expect(page).to have_content 'Titulo tema de prueba'
    expect(page).to have_content 'Descripcion o contenido del tema de prueba'
  end

   scenario 'Eliminar(dejar de mostrar) un tema' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    tema = FactoryGirl.create(:tema)
    #TODO: Tarea para uds. refactorizar esta sección a un método ingresar_sistema(usuario)
    #para no repetir esto en todos los demás feature specs que necesiten autentificarse
    ingresar_sistema(usuario)
    visit "temas/1"  #usar el id, titulo del tema con creado con factory girl
    click_link 'Eliminar Tema' # ya no quiero ver el tema
    expect(current_path).to eq "/temas" #lista de temas
    expect(page).to have_content '' #no tengo contenido en la pagina
    expect(page).to have_content ''
    #TODO: to change(Tema, :count).by(1)  SE puede investigar si hay algo similar para reducir la cantidad en 1
  end

  scenario 'Ver mis temas' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    click_link 'Nuevo Tema'

    #TODO: Se puede remplazar este bloque usando factory girl??
    #creamos un tema para el usuario1
    fill_in 'tema_titulo', with: 'Titulo tema de prueba'
    fill_in 'tema_cuerpo', with: 'Descripcion o contenido del tema de prueba'
    click_button 'Crear tema'
    #fin bloque

    click_link usuario.correo
    click_link 'Salir'

    usuario2 = FactoryGirl.create(:other_user)

    #TODO: Usar el metodo de ingresar al sistema común que se debería encontrar en el helper
    #Ingresamos al sistema con otro usuario
    visit root_path 
    fill_in 'correo', with: 'email2@email.com'
    fill_in 'contrasenia', with: 'password2'
    click_button 'Ingresar'
    
    #al entrar a 'Mis temas' no debería ver los temas creados por el primer usuario
    #click_link 'Temas'
    click_link 'Mis Temas'
    
    expect(page).to have_no_content 'Titulo tema de prueba'
    expect(page).to have_no_content 'Descripcion o contenido del tema de prueba'
    
  end
  scenario 'Ver tema' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)

    ingresar_sistema(usuario)
    click_link 'Nuevo Tema'
    fill_in 'tema_titulo', with: 'Titulo tema de prueba'
    fill_in 'tema_cuerpo', with: 'Descripcion o contenido del tema de prueba'
    click_button 'Crear tema'

    click_link usuario.correo
    click_link 'Salir'
    
    usuario2=FactoryGirl.create(:other_user)

    visit root_path
    fill_in 'correo', with: 'email2@email.com'
    fill_in 'contrasenia', with: 'password2'
    click_button 'Ingresar'

    #click_link 'Temas'
    click_link 'Ver Temas'
    #al ingresar a Ver Temas debe poder ver los temas creados por otros usuarios
    expect(page).to have_content 'Titulo tema de prueba'
    expect(page).to have_content 'Descripcion o contenido del tema de prueba'
  end

    scenario 'Como creador de grupo eliminar comentarios' do
    docente = FactoryGirl.create(:usuario)
    estudiante = FactoryGirl.create(:other_user_estudiante)
    grupo = FactoryGirl.create(:grupo, usuario_id: docente.id)
    subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: estudiante.id, grupo_id: grupo.id)
    tema=FactoryGirl.create(:tema,titulo:"nuevo",cuerpo:"cuerpo de tema",usuario_id:estudiante.id,visible:1,grupo_id:grupo.id)
    ingresar_sistema(docente)
    visit "/temas/"+tema.id.to_s  #no muy util aqui, pero sirve para mostrar esta opcion
    expect(page).to have_content 'Me Interesa'
  end

end

feature 'Buscar temas' do
    scenario 'la busqueda por descripcion deberia mostrar resultados coherentes' do
        grupo = FactoryGirl.create(:grupo)
        usuario = FactoryGirl.create(:usuario,nombre: "Pedro",apellido: "Suarez", contrasenia: "password",  correo:"email@email.com" )
        tema1 = FactoryGirl.create(:tema, titulo: 'Tema 1', cuerpo: 'primera descripcion')
        tema2 = FactoryGirl.create(:tema, titulo: 'Tema 2', cuerpo: 'descripcion segunda')
        ingresar_sistema(usuario)
        fill_in 'descripcion', with: 'primera'
        click_button 'Buscar Tema'
        expect(page).to have_content('Tema 1')
    end
end
