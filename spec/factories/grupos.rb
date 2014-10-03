# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grupo do
    nombre "Grupo de prueba"
    descripcion "grupo para specs"
    estado false
    llave "qwerty"
    usuario_id nil
  end
end

FactoryGirl.define do
  factory :grupo_publico, class: Grupo do
  nombre "Publico" 
  descripcion "todos deben tener ingreso a temas publicos"
  estado false
  llave "publico"
  end
end
