require 'spec_helper'

describe TemaComentariosController do
  before(:each) do
    controller.class.skip_before_filter :require_log_in #para evitar este filtro de application_controller
  end

  describe 'Crear Comentario' do
      it "guarda en la base de datos el nuevo comentario" do
        expect{
          grupo = FactoryGirl.create(:grupo,nombre: 'Publico')
          tema1 = FactoryGirl.create(:tema, titulo: 'Tema Comentado')
		  comment = FactoryGirl.create(:tema_comentario, cuerpo: "probando", tema_id: tema1.id)
          #post :create, comment: FactoryGirl.attributes_for(:comment, tema_id: tema1.id)
        }.to change(TemaComentario, :count).by(1)
      end
  end

  describe 'Elminar Comentario' do
      it "elimina un comentario de la base de datos" do
        expect{
          grupo = FactoryGirl.create(:grupo,nombre: 'Publico')
          tema1 = FactoryGirl.create(:tema, titulo: 'Tema Comentado')
		      comentario1 = FactoryGirl.create(:tema_comentario, cuerpo: "probando", tema_id: tema1.id)
          comentario2 = FactoryGirl.create(:tema_comentario, cuerpo: "sera eliminado", tema_id: tema1.id)
          comentario2.destroy
        }.to change(TemaComentario, :count).by(1)
      end
  end
end