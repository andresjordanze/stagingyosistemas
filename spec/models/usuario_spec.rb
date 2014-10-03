require 'spec_helper'

describe Usuario do
  it "tiene  un construtor valido" do
    expect(FactoryGirl.build(:usuario)).to be_valid
  end

  it "no es valido si no tiene nombre" do
    usuario = FactoryGirl.build(:usuario, nombre: nil)
    expect(usuario).to have(1).errors_on(:nombre)
    expect(usuario).to_not be_valid 
  end
  
  it "no es valido si no tiene apellido" do
    usuario = FactoryGirl.build(:usuario, nombre: 'andrea', apellido: nil)
    expect(usuario).to have(1).errors_on(:apellido)
    expect(usuario).to_not be_valid 
  end
  
  it "no es valido si no tiene correo" do
    usuario = FactoryGirl.build(:usuario, nombre: 'andrea', apellido: 'quiroga', correo: nil)
    expect(usuario).to have(1).errors_on(:correo)
    expect(usuario).to_not be_valid 
  end
  
  
  
end
