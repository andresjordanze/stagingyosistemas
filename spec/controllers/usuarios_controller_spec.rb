require 'spec_helper'

describe UsuariosController do
  before(:each) do

    
    # POST /usuarios
  def create
    grupo = FactoryGirl.build(:grupo)
    @usuario = Usuario.new(usuario_params) 
    @usuario.save
    redirect_to usuarios_url 
  end

  def edit
    grupo = FactoryGirl.build(:grupo)
    @usuario = Usuario.find(params[:id])
  end
      
  end
end 