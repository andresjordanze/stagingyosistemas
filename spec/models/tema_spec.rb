require 'spec_helper'

describe Tema do
  it "tiene  un factory o construtor valido" do
    expect(FactoryGirl.build(:tema)).to be_valid
  end

  it "no es valido si no tiene titulo" do
    tema = FactoryGirl.build(:tema, titulo: nil)
    expect(tema).to have(1).errors_on(:titulo)
    expect(tema).to_not be_valid 
  end
  
  it "retorna false si NO corresponde a titulo" do
    tema = FactoryGirl.build(:tema, titulo: "prueba")
    expect(tema.correspondeATitulo("titulo")).to be_false
  end
  
  it "retorna true si corresponde a titulo" do
    tema = FactoryGirl.build(:tema, titulo: "prueba")
    expect(tema.correspondeATitulo("pr")).to be_true
  end
  
  it "retorna true si corresponde a titulo compuesto (dos o mas palabras de criterio de busqueda)" do
    tema = FactoryGirl.build(:tema, titulo: "prueba")
    expect(tema.correspondeATitulo("pr e")).to be_true
  end
end


