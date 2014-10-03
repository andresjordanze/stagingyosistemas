# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cuestionario do
    titulo "MyString"
    descripcion "MyText"
    fecha_limite "2013-11-23 13:10:16"
    estado false
    grupo nil
    usuario nil
  end
end
