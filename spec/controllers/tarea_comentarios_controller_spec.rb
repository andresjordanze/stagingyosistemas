require 'spec_helper'

describe TareaComentariosController do

  before(:each) do
    controller.class.skip_before_filter :require_log_in 
  end

  describe 'Crear Comentario Tarea' do
      it "guarda en la base de datos el nuevo comentario" do
        expect{
          grupo = FactoryGirl.create(:grupo,nombre: 'Publico')
          tarea = FactoryGirl.create(:tarea, titulo: 'Tarea a comentar')
		  comentario = FactoryGirl.create(:tarea_comentario, cuerpo: "probando", tarea_id: tarea.id)
        }.to change(TareaComentario, :count).by(1)
      end
  end

  describe 'Elminar Comentario Tarea' do
      it "elimina un comentario de la base de datos" do
        expect{
          grupo = FactoryGirl.create(:grupo,nombre: 'Publico')
          tarea = FactoryGirl.create(:tarea, titulo: 'Tarea a comentar')
		      comentario1 = FactoryGirl.create(:tarea_comentario, cuerpo: "probando", tarea_id: tarea.id)
          comentario2 = FactoryGirl.create(:tarea_comentario, cuerpo: "sera eliminado", tarea_id: tarea.id)
          comentario2.destroy
        }.to change(TareaComentario, :count).by(1)
      end
  end
end
