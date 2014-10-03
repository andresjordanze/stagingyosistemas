require 'spec_helper'

describe TemaComentario do
  it "tiene un factory o construtor valido" do
    expect(FactoryGirl.build(:tema_comentario)).to be_valid
  end

  it "no es valido si no tiene comentario" do
    comentario = FactoryGirl.build(:tema_comentario, cuerpo: nil)
    expect(comentario).to have(1).errors_on(:cuerpo)
    expect(comentario).to_not be_valid 
  end
end
