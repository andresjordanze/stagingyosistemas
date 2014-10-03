require 'spec_helper'

feature 'Gestion de usuarios' do
  
  scenario 'modificar un usuario' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    ingresar_sistema(usuario)
    click_link 'Modificar Perfil' # entra al link de modificar perfil
      fill_in 'usuario_nombre', with: 'otro' #el texto se llena con 
      fill_in 'usuario_apellido', with: 'otroapellido'
      click_button 'Guardar'
      Usuario.first.nombre == 'otro'  #no muy util aqui, pero saber si cambio el nombre de usuario
      Usuario.first.apellido == 'otroapellido'
  end
  
  scenario 'modificar un contrasenia' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    ingresar_sistema(usuario)
    #click_link 'Modificar Contrasea' # entra al link de modificar perfil
    visit update_password_path
      fill_in 'contrasenia', with: 'password' #el texto se llena con 
      fill_in 'contrasenia_nueva', with: 'nueva'
      fill_in 'contrasenia_nueva2', with: 'nueva'
      click_button 'Guardar'
      Usuario.first.contrasenia == Digest::MD5.hexdigest('nueva')  
  end

  scenario 'recuperar mi contrasenia' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    request=FactoryGirl.create(:solicitud_contrasenium)
    usuario.solicitud_contrasenia_id=request.id
    request.usuario=usuario
    usuario.save
    request.save
    visit recover_path(usuario.id, request.id)
      fill_in 'contrasenia_nueva', with: 'nuevoPass'
      fill_in 'contrasenia_nueva2', with: 'nuevoPass'
      click_button 'Confirmar'
     expect(current_path).to eq root_path
  end

  scenario 'recuperar mi contrasenia, solicitud expiro' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    request=FactoryGirl.create(:solicitud_contrasenium)
    request2=FactoryGirl.create(:solicitud_contrasenium)
    usuario.solicitud_contrasenia_id=request2.id
    request.usuario=usuario
    request2.usuario=usuario
    usuario.save
    request.save
    visit recover_path(usuario.id,request.id)
    expect(page).to have_content 'esta solicitud expiro, por favor solicite otra'
  end

  scenario 'recuperar mi contrasenia, imposible procesar solicitud' do
    grupo = FactoryGirl.create(:grupo)
     usuario = FactoryGirl.create(:usuario)
    request=FactoryGirl.create(:solicitud_contrasenium)
    usuario.solicitud_contrasenia_id=request.id
    request.usuario=usuario
    usuario.save
    request.save
    visit recover_path("imposible","imposible")
    expect(page).to have_content 'no podemos procesar esta solicitud, por favor solicite otra'
  end

  scenario 'Ver perfil de usuario' do
    grupo = FactoryGirl.create(:grupo)
    usuario=FactoryGirl.create(:usuario)
    ingresar_sistema(usuario)
    click_link 'Ver Perfil'
    expect(current_path).to eq ("/usuarios/"+usuario.id.to_s)
    
    expect(page).to have_field("usuario_nombre", :with=>"Pedro", :disabled => true) 
    expect(page).to have_field("usuario_apellido", :with=>"Pedregal", :disabled => true)
    expect(page).to have_field("usuario_correo", :with=>"email@email.com", :disabled => true)
  end

  scenario 'recuperar mi contrasenia, no puede recuperar si esta loggeado' do
    grupo = FactoryGirl.create(:grupo)
     usuario = FactoryGirl.create(:usuario)
    request=FactoryGirl.create(:solicitud_contrasenium)
    usuario.solicitud_contrasenia_id=request.id
    request.usuario=usuario
    usuario.save
    request.save
    ingresar_sistema(usuario)
    visit recover_path(usuario.id,request.id)
    expect(page).to have_content 'no puede recuperar su password si esta loggeado'
  end
  scenario 'Activar cuenta' do
    grupo = FactoryGirl.create(:grupo)
     usuario = FactoryGirl.create(:other_diferent_user)
    visit confirm_path(usuario.id)
    expect(page).to have_content 'Su cuenta fue activada exitosamente! ya puede hacer uso de nuestro contenido'
  end

  scenario 'Activar cuenta, no puede activar si esta loggeado' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    ingresar_sistema(usuario)
    visit confirm_path(usuario.id)
    expect(page).to have_content "No puede activar su cuenta si esta loggeado"
    end

  #scenario 'No deberia registrar un usuario con un email repetido' do
    #grupo = FactoryGirl.create(:grupo)
    #usuario = FactoryGirl.create(:usuario)
    #visit root_path
    #click_button 'Registrarse'
    #fill_in 'usuario[correo]', with: 'email@email.com'
    #click_button "Registrar"
    #expect(page).to have_content "Correo ya existente"

  #end
  scenario 'Activar cuenta, usuario incorrecto' do
    visit confirm_path("imposible")
    expect(page).to have_content 'Error, datos invalidos'
    end
    scenario 'No deberia poder acceder a forgot password loggeado' do
      grupo = FactoryGirl.create(:grupo)
     usuario = FactoryGirl.create(:usuario)
     ingresar_sistema(usuario)
     visit forgot_password_path
     expect(current_path).to eq root_path

    end
  
  scenario 'Crear un usuario de rol docente' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)    
    expect(usuario.rol).to eq 'Docente'  
  end

  scenario 'Crear un usuario de rol estudiante' do
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:other_user_estudiante)    
    usuario.rol == 'Estudiante'  
  end
end
