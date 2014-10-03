# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :respuesta_usuario do
    respuesta "MyString"
    tipo "MyString"
    cuestionario nil
    usuario nil
    pregunta nil
  end
end
