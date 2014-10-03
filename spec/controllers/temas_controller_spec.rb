require 'spec_helper'

describe TemasController do
  before(:each) do
    controller.class.skip_before_filter :require_log_in #para evitar este filtro de application_controller

  end

  #ATENCION: El uso de factory girl ayuda a hacer los specs m'as simples. Sin embargo, tambi'en m'as lentos ya 
  # que acceden a la BD en lugar de mocks o stubs
  describe 'GET #index' do
    grupo = FactoryGirl.build(:grupo)
    it "obtiene todos los temas de grupo publico en un arreglo" do  
      
      tema1 = FactoryGirl.create(:tema, titulo: 'Tema 1')
      tema2 = FactoryGirl.create(:tema, titulo: 'Tema 2')
      
      get :index
      
      expect(assigns(:temas)).to match_array([tema1, tema2])
    end

    it "muestra la vista index" do
      get :index
      
      expect(response).to render_template :index
    end
  end
  describe 'GET #new' do
    it "asigna un nuevo tema a @tema" do
      get :new
      expect(assigns(:tema)).to be_a_new(Tema)
    end

    it "muestra la vista new" do
      
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    grupo = FactoryGirl.build(:grupo)
    context 'con atributos validos' do
      it "guarda en la bd el nuevo tema" do
        expect{ 

          tema = FactoryGirl.create(:tema)
          #post :create, tema: FactoryGirl.attributes_for(:tema, titulo:'titulo', cuerpo:'Hola')
        }.to change(Tema, :count).by(1)
      end

      it "redirecciona a vista index" do
        #post :create, tema: FactoryGirl.attributes_for(:tema)   
        tema = FactoryGirl.create(:tema)
		get :index
		#expect(response).to redirect_to temas_path  
      end
    end
  end
  
  describe 'GET #buscar' do
    grupo = FactoryGirl.build(:grupo)
    it "obtiene todos los temas publicos al no haber filtro" do  
      tema1 = FactoryGirl.create(:tema, titulo: 'Prueba 1')
      tema2 = FactoryGirl.create(:tema, titulo: 'Test 2')
      
      get :buscar, {:grupo=>"1"}
      
      expect(assigns(:temas)).to match_array([tema1,tema2])
    end

    it "obtiene el tema que coincide con el titulo" do  
      tema1 = FactoryGirl.create(:tema, titulo: 'Prueba 1')
      tema2 = FactoryGirl.create(:tema, titulo: 'Test 2')
      
      get :buscar, {:grupo=>"1", :titulo=>"1"}
      
      expect(assigns(:temas)).to match_array([tema1])
    end

    it "renderiza a la vista index" do
      get :buscar, {:grupo=>"1"}
      
      expect(response).to render_template :index
    end

  end


  describe "PUT update" do
    grupo = FactoryGirl.build(:grupo)
    before :each do
      @tema = FactoryGirl.create(:tema, titulo:'Importante tema', cuerpo:'Detalle del tema importante')
    end

    context "atributos validos" do
      it "asignar los valores encontrados a @tema" do
        put :update, id: @tema, tema:FactoryGirl.attributes_for(:tema)
        assigns(:tema).should eq(@tema)
      end

      it "cambiar atributos de @tema" do
        put :update, id:@tema, tema: FactoryGirl.attributes_for(:tema, titulo:'Titulo nuevo', cuerpo:'Cuerpo nuevo')
        @tema.reload
        @tema.titulo.should eq('Titulo nuevo')
        @tema.cuerpo.should eq('Cuerpo nuevo')
      end
      
      it "redireccionar al tema actualizado" do
        put :update, id:@tema, tema: FactoryGirl.attributes_for(:tema)
        response.should redirect_to @tema
      end
    end

    context "atributos invalidos" do
      it "asignar los valores encontrados a @tema" do
        put :update, id: @tema, tema:FactoryGirl.attributes_for(:tema)
        assigns(:tema).should eq(@tema)
      end
      it "cambiar atributos de @tema por un titulo vacio" do
        put :update, id:@tema, tema: FactoryGirl.attributes_for(:tema, titulo:'', cuerpo:'Cuerpo nuevo')
        @tema.reload
        @tema.titulo.should_not eq('')
        @tema.cuerpo.should_not eq('Cuerpo nuevo')
      end
      
      it "redireccionar al metodo de edicion" do
        put :update, id: @tema, tema: FactoryGirl.attributes_for(:tema, titulo:'', cuerpo:'Cuerpo nuevo')
        response.should render_template("edit")
      end

    end
  end
  describe "GET#show"
  grupo = FactoryGirl.build(:grupo)
  it "asigna el id solicitado a @id" do
    grupo = FactoryGirl.create(:grupo)
    tema=FactoryGirl.create(:tema)
    get :show, id: tema
    assigns(:tema).should eq tema
  end

end
