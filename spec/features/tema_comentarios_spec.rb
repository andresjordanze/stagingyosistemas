require 'spec_helper'

feature 'Comentario' do
  
  scenario 'Comentar tema' do
    #crear usuario que pueda crear una entrada (cuando se tenga usuarios)
    grupo = FactoryGirl.create(:grupo)
    usuario = FactoryGirl.create(:usuario)
    tema=FactoryGirl.create(:tema)
    ingresar_sistema(usuario)
    visit "temas/"+tema.id.to_s #voy al tema (esta parte necesita ser refactorizada)
    expect{
      fill_in 'tema_comentario_cuerpo', with: 'contenido del comentario'
      click_button 'Comentar'
    }.to change(TemaComentario, :count).by(1)
    expect(page).to have_content 'contenido del comentario' 
  end
  scenario 'Como creador de grupo eliminar comentarios' do
    docente = FactoryGirl.create(:usuario)
    estudiante = FactoryGirl.create(:other_user_estudiante)
    grupo = FactoryGirl.create(:grupo, usuario_id: docente.id)
    subscripcion = FactoryGirl.create(:subscripcion, llave: "qwerty", usuario_id: estudiante.id, grupo_id: grupo.id)
    tema=FactoryGirl.create(:tema,titulo:"nuevo",cuerpo:"cuerpo de tema",usuario_id:estudiante.id,visible:1,grupo_id:grupo.id)
    comentario=FactoryGirl.create(:tema_comentario,cuerpo:"comentario",tema_id:tema.id,usuario_id:estudiante.id)
    ingresar_sistema(docente)
    visit "/temas/"+tema.id.to_s  #no muy util aqui, pero sirve para mostrar esta opcion
    expect(page).to have_content 'Eliminar'
  end

end