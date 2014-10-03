require 'spec_helper'

feature 'Gestion de tareas' do
  #TODO: Llevar este método a un spec_helper para que sea usado por todos los feature specs
  #TODO: Usar el parametro usuario en este método
  before(:all) do
     @grupo_publico = FactoryGirl.create(:grupo_publico)
  end

  scenario 'Crear una tarea' do
     usuario = FactoryGirl.create(:usuario)
     grupo = FactoryGirl.create(:grupo, usuario_id: usuario.id)
     subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: usuario.id, grupo_id: grupo.id)
     ingresar_sistema(usuario)
     visit "/grupos/"+grupo.id.to_s+"/tareas"
     click_link 'Nueva Tarea'
     fill_in 'tarea_titulo', with: 'Titulo tarea de prueba'
     fill_in 'tarea_descripcion', with: 'Descripcion o contenido de tarea de prueba'
     fill_in 'tarea_fecha_entrega', with: '12/12/2013'
     fill_in 'tarea_hora_entrega', with: '05:00 PM'
     click_button 'Crear tarea'
     expect(page).to have_content 'Titulo tarea de prueba'
     expect(page).to have_content 'Descripcion o contenido de tarea de prueba'
   end

   scenario 'Ver detalle de una tarea' do
     usuario = FactoryGirl.create(:usuario)
     grupo = FactoryGirl.create(:grupo, usuario_id: usuario.id)
     subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea, usuario_id: usuario.id, grupo_id: grupo.id)
     ingresar_sistema(usuario)
     visit "/tareas/"+tarea.id.to_s
     expect(page).to have_content 'pedrito' #deberia tener, el username del que creador de la tarea
     expect(page).to have_content 'Tarea de Prueba' #deberia tener, el titulo de la tarea
     expect(page).to have_content 'Una tarea de prueba no muy larga para que no se resuma' #deberia tener, la descripcion
     expect(page).to have_content '13/Oct/2014' #deberia tener, la fecha de entrega
     expect(page).to have_content '10:00 PM' #deberia tener, la hora de entrega
  end

  scenario 'Eliminar una tarea' do
     usuario = FactoryGirl.create(:usuario)
     grupo = FactoryGirl.create(:grupo, usuario_id: usuario.id)
     subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea, usuario_id: usuario.id, grupo_id: grupo.id)
     ingresar_sistema(usuario)
     visit "/tareas/"+tarea.id.to_s
     click_link 'Eliminar'
     #click_button 'Aceptar'
     expect(page).to have_content 'Tarea eliminada' #deberia tener, la hora de entrega
   end
 
  # scenario 'Ver index de tareas de un grupo' do
  #   usuario = FactoryGirl.create(:usuario)
  #   publico = FactoryGirl.create(:grupo)
  #   grupo = FactoryGirl.create(:grupo, nombre: 'Prueba', usuario_id: usuario.id)
  #   tarea1 = FactoryGirl.create(:tarea, titulo: 'Tarea 1', grupo_id: "2", fecha_entrega: "2013-10-13", hora_entrega: "00:00 AM")
  #   tarea2 = FactoryGirl.create(:tarea, titulo: 'Tarea 2', grupo_id: "2", fecha_entrega: "2013-10-13", hora_entrega: "00:00 AM")
  #   ingresar_sistema(usuario)
  #   visit "/grupos/2/tareas"
  #   #expect(current_path).to eq "/grupos/2/tareas"  #no muy util aqui, pero sirve para mostrar esta opcion
  #   expect(page).to have_content 'Tarea 1'
  #   expect(page).to have_content 'Tarea 2'
  # end

  scenario 'Responder una tarea' do
   usuario = FactoryGirl.create(:usuario_estudiante)
   usuario_docente = FactoryGirl.create(:usuario)
     grupo = FactoryGirl.create(:grupo, usuario_id: usuario.id)
     subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea, usuario_id: usuario_docente.id, grupo_id: grupo.id)
    visit root_path
    fill_in 'correo', with: "email666@email666.com"
    fill_in 'contrasenia', with: "password"
    click_button 'Ingresar'



    visit "/tareas/"+tarea.id.to_s
    expect(current_path).to eq "/tareas/"+tarea.id.to_s
    click_link "Responder"
    expect{
    fill_in 'responder_tarea_descripcion', with: 'Descripcion de prueba' 
    click_button "Responder"  }.to change(ResponderTarea, :count).by(1)
  end

  scenario 'No puedo responder una tarea si ya lo hice' do
    estudiante = FactoryGirl.create(:usuario_estudiante)
    docente = FactoryGirl.create(:usuario)
    grupo = FactoryGirl.create(:grupo, usuario_id: docente.id)
    subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: estudiante.id, grupo_id: grupo.id)
    tarea = FactoryGirl.create(:tarea, usuario_id: docente.id, grupo_id: grupo.id)
    visit root_path
    fill_in 'correo', with: "email666@email666.com"
    fill_in 'contrasenia', with: "password"
    click_button 'Ingresar'
    visit "/tareas/"+tarea.id.to_s
    click_link "Responder"
    fill_in 'responder_tarea_descripcion', with: 'Descripcion de prueba' 
    click_button "Responder"
    visit "/tareas/"+tarea.id.to_s
    expect(page).to have_no_content 'Responder'
    expect(page).to have_content 'Ya respondio esta tarea'

  end
  scenario 'Un docente no puede responder una tarea como creador de la misma' do
    docente = FactoryGirl.create(:usuario)
    grupo = FactoryGirl.create(:grupo, usuario_id: docente.id)
    subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: docente.id, grupo_id: grupo.id)
    tarea = FactoryGirl.create(:tarea, usuario_id: docente.id, grupo_id: grupo.id)
    visit root_path
    ingresar_sistema(docente)
    visit "/tareas/"+tarea.id.to_s
    expect(page).to have_no_content 'Responder'
  end

  scenario 'Ver lista de tareas' do
    usuario = FactoryGirl.create(:usuario)
     grupo = FactoryGirl.create(:grupo, usuario_id: usuario.id)
     subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea, usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea2, usuario_id: usuario.id, grupo_id: grupo.id)
     tarea = FactoryGirl.create(:tarea3, usuario_id: usuario.id, grupo_id: grupo.id)
     visit "/grupos/"+grupo.id.to_s+"/temas-y-tareas"
     expect(page).to have_content 'Tarea de Prueba'
     expect(page).to have_content 'Tarea de Prueba 2'
     expect(page).to have_content 'Tarea de Prueba 3'
  end

end