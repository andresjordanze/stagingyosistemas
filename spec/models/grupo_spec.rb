require 'spec_helper'

describe Grupo do
  it "tiene  un factory o construtor valido" do
    expect(FactoryGirl.build(:grupo)).to be_valid
  end

  it "no es valido si no tiene un nombre de grupo" do
    grupo = FactoryGirl.build(:grupo, nombre: nil)
    expect(grupo).to have(1).errors_on(:nombre)
    expect(grupo).to_not be_valid 
  end

  it "retorna false si NO corresponde a nombre" do
    grupo = FactoryGirl.build(:grupo, nombre: "prueba")
    expect(grupo.correspondeAGrupo("nombre")).to be_false
  end
  
  it "retorna true si corresponde a nombre" do
    grupo = FactoryGirl.build(:grupo, nombre: "prueba")
    expect(grupo.correspondeAGrupo("pr")).to be_true
  end
  
  it "retorna true si corresponde a nombre compuesto (dos o mas palabras de criterio de busqueda)" do
    grupo = FactoryGirl.build(:grupo, nombre: "prueba")
    expect(grupo.correspondeAGrupo("pr e")).to be_true
  end
  
end
